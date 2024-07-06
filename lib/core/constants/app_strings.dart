class AppStrings {
  // CONSTRUCTOR
  AppStrings._();

  // SINGLETON
  static final AppStrings instance = AppStrings._();

  // A
  static const String appDrawerItemAbout                    = 'Acerca de';
  static const String appDrawerItemActivity                 = 'Actividad';
  static const String appDrawerItemDashboard                = 'Dashboard';
  static const String appDrawerItemHelp                     = 'Ayuda y comentarios';
  static const String appDrawerItemHome                     = 'Inicio';
  static const String appDrawerItemLogout                   = 'Cerrar sesión';
  static const String appDrawerItemNotification             = 'Notificaciones';

  static const String appDrawerItemSettingsInspeccion       = 'Configuración de inspecciones';

  static const String appPageDefaultTitlePage               = 'página';
  static const String appPageSemanticSwipe                  = '{pageTitle} {count} de {total}.';
  static const String appPageProcessingData                 = 'Procesando...';

  static const String authSignInTitle                       = 'Iniciar sesión';
  static const String authSignInErrorDialogMessage          = 'Se produjo un error inesperado. Intenta de nuevo iniciar sesión.';

  // B
  static const String btnAcceptText                         = 'Aceptar';
  static const String btnAddText                            = 'Agregar';
  static const String btnCancelText                         = 'Cancelar';
  static const String btnCloseText                          = 'Cerrar';
  static const String btnContinueText                       = 'Continuar';
  static const String btnCreateCategoriaText                = 'Nueva categoría';
  static const String btnCreateInspeccionTipoText           = 'Nuevo tipo de inspección';
  static const String btnDeleteText                         = 'Eliminar';
  static const String btnDisableText                        = 'Inhabilitar';
  static const String btnEditText                           = 'Editar';
  static const String btnGoBackText                         = 'Volver a inicio';
  static const String btnJoinText                           = 'Ingresar';
  static const String btnLeaveText                          = 'Salir';
  static const String btnLoadMoreText                       = 'Cargar más';
  static const String btnLoginText                          = 'Iniciar sesión';
  static const String btnLogoutText                         = 'Cerrar sesión';
  static const String btnRefreshText                        = 'Actualizar';
  static const String btnRetryText                          = 'Reintentar';
  static const String btnSaveText                           = 'Guardar';
  static const String btnSubmitText                         = 'Enviar';

  // C
  static const String categoriaAppBarTitle                  = 'Configuración de categorías';
  static const String categoriaBoxDescription               = 'Crea categorías para agrupar las preguntas de las inspecciones.';
  static const String categoriaCreateAppBarTitle            = 'Nueva categoría';
  static const String categoriaEditAppBarTitle              = 'Editar: {categoria}';
  static const String categoriaEmptyListTitle               = 'Aún no hay categorías';
  static const String categoriaCreatePreguntasText          = 'Crear preguntas';
  static const String categoriaDeleteAlertTitle             = '¿Eliminar categoría?';
  static const String categoriaDeleteAlertFirstText         = 'Se eliminará la categoría ';
  static const String categoriaDeleteAlertSecondText        = '\n¿Estás seguro de querer realizar esa acción?';

  static const String categoriaItemAppBarTitle              = 'Configuración de preguntas';
  static const String categoriaItemBoxDescription           = 'Crea las preguntas necesarias para la evaluación e inspección de una unidad.';
  static const String categoriaItemCreateTooltip            = 'Nueva pregunta';
  static const String categoriaItemDeleteAlertFirstText     = 'Se eliminará la pregunta ';
  static const String categoriaItemDeleteAlertSecondText    = '¿Estás seguro de querer realizar esa acción?';
  static const String categoriaItemDeleteAlertTitle         = '¿Eliminar pregunta?';
  static const String categoriaItemEmptyListTitle           = 'Aún no hay preguntas';

  // D
  static const String defaultAppName                        = 'EOS Mobile';
  static const String defaultPageTitle                      = 'Página';

  // E
  static const String errorAlertTitle                       = 'Error';
  static const String emptyListSyncMessage                  = 'Intenta actualizar el listado para sincronizar los últimos cambios del servidor.';
  static const String emptyPageAppBarTitle                  = 'Página vacía';
  static const String errorPageNotFoundSemanticLabel        = 'Error 404';
  static const String errorPageNotFoundTitle                = '¡Oh, no! \nPágina no encontrada.';
  static const String errorServerSemanticLabel              = 'Error 500';
  static const String errorServerTitle                      = '¡Oh, no! \nSe produjo un error en nuestro sistema.';

  static const String errorBadCertificateMessage            = 'Certificado inválido.';
  static const String errorConnectionMessage                = 'Error de conexión. Por favor, verifica tu conexión a internet.';
  static const String errorConnectionTimeoutMessage         = 'Se agotó el tiempo de conexión con el servidor. Por favor, verifica tu conexión a internet.';
  static const String errorGenericMessage                   = 'Se produjo un error inesperado. Inténtalo de nuevo.';
  static const String errorReceiveTimeoutMessage            = 'Se agotó el tiempo de recepción. Inténtalo de nuevo más tarde.';
  static const String errorSendTimeoutMessage               = 'Se agotó el tiempo de envío. Inténtalo de nuevo más tarde.';
  static const String errorServerCancelMessage              = 'La solicitud al servidor ha sido cancelada. Inténtalo de nuevo más tarde.';
  static const String errorUnknownMessage                   = 'Error desconocido. Inténtalo de nuevo más tarde.';

  static const String errorBadResponseInfoMessage           = 'Respuesta informativa: {statusCode}; Se ha recibido la solicitud, que sigue procesándose.';
  static const String errorBadResponseSuccessMessage        = 'Respuesta satisfactoria: {statusCode}; La solicitud se ha recibido, comprendido y aceptado correctamente.';
  static const String errorBadResponseRedirectMessage       = 'Redirección: {statusCode}; Es necesario realizar más acciones para completar la solicitud.';
  static const String errorBadResponseClientErrorMessage    = 'Error del cliente: {statusCode}; La solicitud contiene una sintaxis incorrecta o no puede cumplirse.';
  static const String errorBadResponseServerErrorMessage    = 'Error del servidor: {statusCode}; El servidor no ha podido responder a una solicitud aparentemente válida.';
  static const String errorBadResponseUnknownMessage        = 'Una respuesta con un código de estado que no se encuentra entre 100 y 600. Es una respuesta no estándar, posiblemente debida al software del servidor.';

  // F
  static const String forgotPasswordAppBarTitle             = '¿Has olvidado tu contraseña?';
  static const String forgotPasswordBoxMessage              = 'Completa el formulario para restablecer su contraseña';

  // H
  static const String homeMenuAboutEosMobile                = 'EOS Mobile agiliza los procesos internos de la empresa {heavyLiftUrl}. ';
  static const String homeMenuAboutBuiltApp                 = 'Desarrollado con {flutterUrl} para ofrecer una experiencia nativa.';
  static const String homeMenuAboutProcessApp               = 'Facilita la centralización de tareas y operaciones en un único lugar, mejorando la productividad.';

  static const String homeFirstModuleCardTitle              = 'Inspecciones';
  static const String homeSecondModuleCardTitle             = 'Compras';
  static const String homeThirdModuleCardTitle              = 'Embarques';
  static const String homeFourthModuleCardTitle             = 'Unidades';

  // I
  static const String inspeccionMenuIndexPageSubtitle       = 'Muestra las inspecciones generales.';
  static const String inspeccionMenuIndexPageTitle          = 'Listado de inspecciones';
  static const String inspeccionMenuUnidadPageSubtitle      = 'Encuentra unidades con inspecciones recientes.';
  static const String inspeccionMenuUnidadPageTitle         = 'Buscar unidad';

  static const String inspeccionIndexAppBarTitle            = 'Inspecciones';

  static const String inspeccionTipoAppBarTitle             = 'Configuración de inspecciones';
  static const String inspeccionTipoBoxDescription          = 'Crea los tipos de inspección para organizar y gestionar tus inspecciones de manera eficiente.';
  static const String inspeccionTipoBoxTitle                = 'Tipos de inspecciones';
  static const String inspeccionTipoCreateAppBarTitle       = 'Nuevo tipo de inspección';
  static const String inspeccionTipoCreateCategoriasText    = 'Crear categorías';
  static const String inspeccionTipoEmptyListTitle          = 'Aún no hay tipos de inspecciones';
  static const String inspeccionTipoEditAppBarTitle         = 'Editar: {inspeccionTipo}';
  static const String inspeccionTipoDeleteAlertTitle        = '¿Eliminar tipo de inspección?';
  static const String inspeccionTipoDeleteAlertFirstText    = 'Se eliminará el tipo de inspección ';
  static const String inspeccionTipoDeleteAlertSecondText   = 'con el código {codigo}. \n¿Estás seguro de querer realizar esa acción?';

  // L
  static const String logoutAlertDialogTitle                = '¿Salir de tu cuenta?';
  static const String logoutRedirectTitle                   = '¡Te has desconectado!';
  static const String logoutRedirectMessage                 = 'Has sido redirigido al inicio de sesión.';

  // S
  static const String searchInputHintText                   = 'Buscar...';
  static const String searchInputSemanticClear              = 'Limpiar';

  static const String settingsAppBarTitle                   = 'Configuración general';
  static const String settingsAutoUpdateTitle               = 'Actualizar automáticamente';
  static const String settingsAutoUpdateSubtitle            = 'Actualiza la app automáticamente mediante Wi-Fi.';
  static const String settingsChangeThemeTitle              = 'Tema';
  static const String settingsChangeThemeSubtitle           = 'Cambiar tema de la aplicación.';
  static const String settingsDisableUpdateContent          = 'Después de inhabilitar la actualización automática, deberá confirmar manualmente cuando actualice a una nueva versión para poder completar la actualización. ¿Seguro que quiere inhabilitar?';
  static const String settingsDisableUpdateTitle            = 'Inhabilitar actualización automática';
  static const String settingsRecentUpdateTitle             = 'Actualización reciente';
  static const String settingsRecentUpdateSubtitle          = 'Recibe notificaciones cuando haya actualizaciones disponibles.';

  static const String suggestionBoxTitle                    = 'Sugerencia';

  // U
  static const String underConstructionTitle                = '¡Próximamente! \nGracias por tu paciencia 👍.';

  // W
  static const String warningAlertTitle                     = 'Advertencia';

  static const String welcomeFirstPageContent               = 'Accede a los datos del EOS desde cualquier lugar, sincroniza cambios automáticamente.';
  static const String welcomeFirstPageTitle                 = 'Accede al EOS';
  static const String welcomeSecondPageContent              = 'Navega de manera rápida entre los módulos para agilizar el proceso interno.';
  static const String welcomeSecondPageTitle                = 'Explora módulos';
  static const String welcomeSemanticNavigate               = 'Navegar';
  static const String welcomeSemanticEnterApp               = 'Acceder a la aplicación';
  static const String welcomeSemanticSwipeLeft              = 'Desliza a la izquierda para continuar';
  static const String welcomeThirdPageContent               = 'Aprovecha las funcionalidades que ofrece EOS Mobile, mejorando la eficiencia y productividad de tu equipo.';
  static const String welcomeThirdPageTitle                 = 'Eficiencia empresarial';
}
