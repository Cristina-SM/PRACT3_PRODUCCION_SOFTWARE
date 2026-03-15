from datetime import date

import pytest
from pytest_bdd import given, parsers, scenarios, then, when

from core.expense_service import ExpenseService
from core.in_memory_expense_repository import InMemoryExpenseRepository

scenarios("./expense_management.feature")


@pytest.fixture
def context():
    repo = InMemoryExpenseRepository()
    service = ExpenseService(repo)
    return {"service": service, "db": repo}


@given(parsers.parse("un gestor de gastos vacío"))
def empty_manager(context):
    pass


@given(parsers.parse("un gestor con un gasto de {amount:d} euros"))
def manager_with_one_expense(context, amount):
    context["service"].create_expense(
        title="Gasto inicial", amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("añado un gasto de {amount:d} euros llamado {title}"))
def add_expense(context, amount, title):
    context["service"].create_expense(
        title=title, amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("elimino el gasto con id {expense_id:d}"))
def remove_expense(context, expense_id):
    context["service"].remove_expense(expense_id)


@then(parsers.parse("el total de dinero gastado debe ser {total:d} euros"))
def check_total(context, total):
    assert context["service"].total_amount() == total


@then(parsers.parse("debe haber {expenses:d} gastos registrados"))
def check_expenses_length(context, expenses):
    total = len(context["db"]._expenses)
    assert expenses == total


@then(
    parsers.parse(
        "el gasto con id {expense_id:d} debe tener un importe de {amount:d} euros"
    )
)
def check_expense_amount(context, expense_id, amount):
    expense = context["db"].get_by_id(expense_id)
    assert expense is not None
    assert expense.amount == amount


@then(parsers.parse("elimino el gasto inexistente con id {expense_id:d}"))
def remove_nonexistent_expense(context, expense_id):
    value = context["service"].remove_expense(expense_id)
    assert value


@then(parsers.parse("el gasto con id {expense_id:d} no debe existir"))
def check_expense_not_exists(context, expense_id):
    expense = context["db"].get_by_id(expense_id)
    assert expense is None

