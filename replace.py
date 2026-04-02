import os
import re
files = [
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\security\security.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\privacy_policy\privacy_policy.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\faqs\faqs.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\terms_and_condition\terms_and_condition.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\subscription\subscription.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\contact_support\contact_support.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\security\change_password\change_password.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\notification\notification.dart"
]
pattern = re.compile(
    r"GestureDetector\(\s*onTap: \(\) => controller\.goBack\(context\),\s*child: Container\(\s*width: (30|35)\.w,\s*height: (30|35)\.h,\s*clipBehavior: Clip\.antiAlias,\s*decoration: ShapeDecoration\(\s*color: Colors\.black\.withValues\(alpha: 0\.10\),\s*shape: RoundedRectangleBorder\(\s*borderRadius: BorderRadius\.circular\(100\.r\),\s*\),\s*\),\s*child: Icon\(\s*Icons\.arrow_back,\s*(?:size: (24|28)\.sp,\s*color: Colors\.black,|color: Colors\.black,\s*size: (24|28)\.sp,)\s*\),\s*\),\s*\)",
    re.DOTALL
)
for file in files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    def repl(m):
        w = m.group(1)
        h = m.group(2)
        s = m.group(3) if m.group(3) else m.group(4)
        return f"CustomBackButton(\n            onPressed: () => controller.goBack(context),\n            width: {w},\n            height: {h},\n            backgroundColor: Colors.black.withValues(alpha: 0.10),\n            borderRadius: 100,\n            color: Colors.black,\n            size: {s},\n          )"
    new_content = pattern.sub(repl, content)
    with open(file, 'w', encoding='utf-8') as f:
        f.write(new_content)
    if "CustomBackButton" in new_content:
        # Import line to add
        imports = r"import 'package:flutter/material.dart';"
        import_custom = r"import '../../../../widgets/custom_back_button.dart';"
        if "security.dart" in file or "notification.dart" in file or "subscription.dart" in file:
            import_custom = r"import '../../../widgets/custom_back_button.dart';"
        if "change_password.dart" in file:
            import_custom = r"import '../../../../../widgets/custom_back_button.dart';"
        if "custom_back_button.dart" not in new_content:
            new_content = new_content.replace(imports, f"{imports}\n{import_custom}")
        with open(file, 'w', encoding='utf-8') as f:
            f.write(new_content)
print('Done')
