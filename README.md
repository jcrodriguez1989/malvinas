
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{malvinas}`

<!-- badges: start -->
<!-- badges: end -->

Sets de datos de las Islas Malvinas, Georgias del Sur y Sándwich del
Sur. Datos obtenidos de <http://www.veteranos.mindef.gov.ar/>.

## Instalación

Por el momento, se debe instalar `{malvinas}` via GitHub, mediante los
comandos:

``` r
install.packages("remotes")
remotes::install_github("jcrodriguez1989/malvinas")
```

## Ejemplo

``` r
library("malvinas")
dplyr::glimpse(veteranos)
```

    ## Rows: 23,533
    ## Columns: 7
    ## $ Apellidos <chr> "ABACA", "ABAD", "ABAL", "ABALLAY", "ABALOS", "ABATI", "ABBO…
    ## $ Nombres   <chr> "Sabino Benito", "Raul Benito", "Guillermo Daniel", "Eduardo…
    ## $ Arma      <chr> "Ejército", "Ejército", "Ejército", "Ejército", "Ejército", …
    ## $ Grado     <chr> "Sargento Ayudante", "Sargento Ayudante", "Soldado Conscript…
    ## $ Categoria <chr> "Vivos", "Vivos", "Vivos", "Vivos", "Vivos", "Vivos", "Vivos…
    ## $ Sexo      <chr> "Masculino", "Masculino", "Masculino", "Masculino", "Masculi…
    ## $ Documento <int> 12421358, 14899442, 14686467, 11973483, 10993984, 16362222, …
