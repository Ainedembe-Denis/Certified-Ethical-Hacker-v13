import os
import re

mods = {
    'Module 18 - IoT and OT Hacking': {
        'About': '> **ℹ️ About these Notes**\n> These notes comprehensively detail IoT architectures, the OWASP Top 10 IoT Threats, OT concepts, and various attack vectors targeting industrial control systems. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.',
        'Name': 'Module 18: IoT and OT Hacking'
    },
    'Module 19 - Cloud Computing': {
        'About': '> **ℹ️ About these Notes**\n> These notes comprehensively detail cloud computing models, the OWASP Top 10 for Cloud and Serverless, and attack methodologies for AWS, Azure, GCP, and containerized environments. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.',
        'Name': 'Module 19: Cloud Computing'
    },
    'Module 20 - Cryptography': {
        'About': '> **ℹ️ About these Notes**\n> These notes comprehensively detail encryption algorithms, cryptography applications like PKI, various cryptanalysis methods, and emerging threats from quantum computing. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.',
        'Name': 'Module 20: Cryptography'
    }
}

base_dir = r'd:\CEH-Certification\Certified-Ethical-Hacker-v13'

for mod, info in mods.items():
    mod_dir = os.path.join(base_dir, mod)
    files = [f for f in os.listdir(mod_dir) if f.endswith('.md')]
    files.sort()
    
    for i, file in enumerate(files):
        filepath = os.path.join(mod_dir, file)
        
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Replace the broken generic notes (handles ?? or ℹ️)
        content = re.sub(r'> \*\*.\s?About these Notes\*\*.*?preparation\.', info['About'], content, flags=re.DOTALL)
        content = re.sub(r'> \*\*.\s?.\s?About these Notes\*\*.*?preparation\.', info['About'], content, flags=re.DOTALL)
        
        # Remove any existing footer to prevent duplicates
        content = re.sub(r'\n---\n\n\*\s*📚 CEH v13.*', '', content, flags=re.DOTALL)
        
        # Generate new footer
        basename = os.path.splitext(file)[0]
        footer = f'\n\n---\n\n*📚 CEH v13 · {info["Name"]} | {basename}'
        
        if i > 0:
            prev_name = os.path.splitext(files[i-1])[0]
            footer += f' | Prev: {prev_name}'
            
        if i < len(files) - 1:
            next_name = os.path.splitext(files[i+1])[0]
            footer += f' | Next: {next_name}'
            
        footer += '*'
        content += footer
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

print("Updates applied.")
