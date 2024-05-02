/// Unificación de las librerías que son comunes en toda la aplicación.
library;

export 'dart:math';

// DIO (HTTP)
export 'package:dio/dio.dart';

// CONFIGURATION
export 'package:eos_mobile/config/logic/app_logic.dart';
export 'package:eos_mobile/config/logic/settings_logic.dart';
export 'package:eos_mobile/config/router/app_router.dart';

// CORE
export 'package:eos_mobile/core/constants/app_strings.dart';
export 'package:eos_mobile/core/constants/assets.dart';
export 'package:eos_mobile/core/constants/globals.dart';

export 'package:eos_mobile/core/enums/app_icons.dart';

export 'package:eos_mobile/core/extensions/alignments_extension.dart';
export 'package:eos_mobile/core/extensions/sized_context_extension.dart';
export 'package:eos_mobile/core/extensions/string_extension.dart';

export 'package:eos_mobile/core/network/api_response.dart';
export 'package:eos_mobile/core/network/data_state.dart';
export 'package:eos_mobile/core/network/errors/exceptions.dart';

export 'package:eos_mobile/core/usecases/usecase.dart';

export 'package:eos_mobile/core/validators/form_validators.dart';

// LAYOUTS
export 'package:eos_mobile/layouts/app_scaffold.dart';
export 'package:eos_mobile/layouts/app_scaffold_with_navbar.dart';

// MAIN
export 'package:eos_mobile/main.dart';

// STYLES
export 'package:eos_mobile/styles/app_styles.dart';

// COMMON ELEMENTS
export 'package:eos_mobile/ui/common/controls/app_loading_indicator.dart';
export 'package:eos_mobile/ui/common/controls/buttons.dart';
export 'package:eos_mobile/ui/common/controls/circle_buttons.dart';
export 'package:eos_mobile/ui/common/controls/labeled_dropdown_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_dropdown_form_search_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_password_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_text_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_textarea_form_field.dart';
export 'package:eos_mobile/ui/common/controls/scroll_decorator.dart';
export 'package:eos_mobile/ui/common/error_box_container.dart';
export 'package:eos_mobile/ui/common/modals/form_modal.dart';

// EQUATABLE
export 'package:equatable/equatable.dart';

// FLEX SEED SCHEME
export 'package:flex_color_scheme/flex_color_scheme.dart';

// FLUTTER (FRAMEWORK)
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

// ANIMATIONS
export 'package:flutter_animate/flutter_animate.dart';

// FLUTTER BLOC
export 'package:flutter_bloc/flutter_bloc.dart';

// FLUTTER SECURE STORAGE
export 'package:flutter_secure_storage/flutter_secure_storage.dart';

// FLUTTER SVG
export 'package:flutter_svg/flutter_svg.dart';

// GAP (FLEX)
export 'package:gap/gap.dart';

// GET IT (DEPENDENCY INJECTION)
export 'package:get_it/get_it.dart';
export 'package:get_it_mixin/get_it_mixin.dart';

// ROUTING
export 'package:go_router/go_router.dart';

// LOGGER
export 'package:logger/logger.dart';

// LOTTIE
export 'package:lottie/lottie.dart';

// SHARED PREFERENCES
export 'package:shared_preferences/shared_preferences.dart';

// SHIMMER
export 'package:shimmer/shimmer.dart';

// UUID
export 'package:uuid/uuid.dart';