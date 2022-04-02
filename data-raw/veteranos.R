# URL del del de datos: www.veteranos.mindef.gov.ar

# Decargado el 02/04/2022.
# Fecha última actualización: Enero de 2022.

# Librerías necesarias.
library("dplyr")
library("glue")
library("purrr")
library("rvest")
library("usethis")

## Descarga de datos.
veteranos_url <- "http://www.veteranos.mindef.gov.ar/listados/"
# Listados.
armas <- c("ejercito", "armada", "fuerzaaerea", "gendarmeria", "prefectura", "estadomayorconjunto")
# Subistados.
categorias <- list(
  "Vivos" = 1,
  "Fallecidos en el TOM/TOAS" = 2,
  "Fallecidos Post-Conflicto" = 3,
  "Veteranos por Sentencia Judicial" = 7,
  "Fallecidos a consecuencias de Malvinas" = 4,
  "Veteranas" = 9
)

# Descargar los datos.
veteranos <- map_dfr(armas, function(arma) {
  print(arma)
  map_dfr(names(categorias), function(categoria) {
    print(categoria)
    # Obtener la url del sublistado.
    veteranos <- read_html(glue("{veteranos_url}/{arma}/{categorias[[categoria]]}"))
    # Filtrar la tabla de veteranos.
    veteranos_tbl <- html_node(veteranos, xpath = '//*[@id="xdia"]') %>%
      html_table() %>%
      mutate(Categoria = categoria)
    if (nrow(veteranos_tbl) == 0) {
      veteranos_tbl <- tibble()
    }
    veteranos_tbl
  })
})

# Transformación de datos.
# La verdad es que no estoy seguro si "Veteranas" se refiere al sexo o al género. TODO: Averiguarlo.
veteranos <- mutate(veteranos, Sexo = if_else(
  Documento %in% filter(veteranos, Categoria == "Veteranas")$Documento, "Femenino", "Masculino")
) %>%
  filter(Categoria != "Veteranas") %>%
  mutate(
    Apellidos = gsub(", .*", "", `Apellido y Nombre`),
    Nombres = gsub(".*, ", "", `Apellido y Nombre`)
  ) %>%
  select(Apellidos, Nombres, Arma, Grado, Categoria, Sexo, Documento)

# Agregar set de datos al paquete R.
use_data(veteranos, overwrite = TRUE)
