Feature: Gestión de gastos
  Como estudiante
  Quiero registrar mis gastos
  Para controlar cuánto dinero gasto

  Scenario: Crear un gasto y comprobar cual es el total que llevo gastado
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    Then el total de dinero gastado debe ser 5 euros

  Scenario: Eliminar un gasto y comprobar cual es el total que llevo gastado
    Given un gestor con un gasto de 5 euros
    When elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear y eliminar un gasto y comprobar que no he gastado dinero
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear dos gastos diferentes y comprobar que el total que llevo gastado es la suma de ambos
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    Then el total de dinero gastado debe ser 15 euros

  Scenario: Crear tres gastos diferentes que sumen 30 euros hace que el total sean 30 euros
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado merienda
    And añado un gasto de 10 euros llamado regalo
    And añado un gasto de 15 euros llamado libro
    Then el total de dinero gastado debe ser 30 euros

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado merienda
    And añado un gasto de 30 euros llamado regalo
    And añado un gasto de 30 euros llamado libro
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado merienda
    And añado un gasto de 30 euros llamado regalo
    And añado un gasto de 30 euros llamado libro
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros

  Scenario: Crear un gasto de 5 y comprobar su importe
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado almuerzo
    And añado un gasto de 10 euros llamado cena
    Then el gasto con id 1 debe tener un importe de 5 euros

  Scenario: Comprobar un gasto que no existe
    Given un gestor de gastos vacío
    When elimino el gasto con id 1
    Then el gasto con id 1 no debe existir

  Scenario: Observar que el total de gastos es 0 cuando no hay gastos registrados
    Given un gestor de gastos vacío
    Then el total de dinero gastado debe ser 0 euros
