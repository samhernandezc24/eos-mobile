enum DataSource {
  success,                // Operación se realizó exitosamente
  noContent,              // Respuesta de la API sin contenido
  badRequest,             // Solicitud enviada a la API incorrectamente
  forbidden,              // Solicitud no autorizada para acceder a recursos
  unauthorised,           // Solicitud no autenticada o sin permisos necesarios
  notFound,               // Recurso solicitado no encontrado en el servidor
  internalServerError,    // Error interno en el servidor
  connectionTimeout,      // Se ha excedido el tiempo de espera de la conexión
  cancel,                 // Solicitud cancelada
  receiveTimeout,         // Se ha excedido el tiempo de espera para recibir datos de la API
  sendTimeout,            // Se ha excedido el tiempo de espera para enviar datos a la API
  cacheError,             // Error relacionado con el almacenamiento en caché de datos
  noInternetConnection,   // No hay conexión a Internet
  defaultValue,           // Valor por defecto para manejar ciertos escenarios
}
