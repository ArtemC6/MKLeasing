enum ReviewTemplateStepType {
  info,
  form,
  multimedia,
}

extension ReviewTemplateStepTypeExt on ReviewTemplateStepType {
  static ReviewTemplateStepType byKeyword(String keyword) {
    switch (keyword) {
      case 'form':
        return ReviewTemplateStepType.form;
      case 'multimedia':
        return ReviewTemplateStepType.multimedia;
      default:
        return ReviewTemplateStepType.info;
    }
  }
}
