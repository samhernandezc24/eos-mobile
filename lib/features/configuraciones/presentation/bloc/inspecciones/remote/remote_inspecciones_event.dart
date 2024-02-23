abstract class RemoteInspeccionesEvent {
  const RemoteInspeccionesEvent();
}

class GetInspecciones extends RemoteInspeccionesEvent {
  const GetInspecciones();
}

class RefreshInspecciones extends RemoteInspeccionesEvent {
  const RefreshInspecciones();
}
