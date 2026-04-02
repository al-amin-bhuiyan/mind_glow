import os
files_to_fix = [
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\security\security.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\faqs\faqs.dart",
    r"C:\Users\shobuj\StudioProjects\mind_glow\lib\views\profile\widgets\support_and_help\privacy_policy\privacy_policy.dart"
]
for file in files_to_fix:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    if 'custom_back_button.dart' not in content:
        imports = r"import 'package:flutter/material.dart';"
        import_str = r"import '../../../../widgets/custom_back_button.dart';"
        content = content.replace(imports, f"{imports}\n{import_str}")
        with open(file, 'w', encoding='utf-8') as f:
            f.write(content)
print("done")
