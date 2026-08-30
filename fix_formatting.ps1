$mods = @{
    'Module 18 - IoT and OT Hacking' = @{
        'About' = '> **ℹ️ About these Notes**`r`n> These notes comprehensively detail IoT architectures, the OWASP Top 10 IoT Threats, OT concepts, and various attack vectors targeting industrial control systems. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.';
        'Name' = 'Module 18: IoT and OT Hacking'
    };
    'Module 19 - Cloud Computing' = @{
        'About' = '> **ℹ️ About these Notes**`r`n> These notes comprehensively detail cloud computing models, the OWASP Top 10 for Cloud and Serverless, and attack methodologies for AWS, Azure, GCP, and containerized environments. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.';
        'Name' = 'Module 19: Cloud Computing'
    };
    'Module 20 - Cryptography' = @{
        'About' = '> **ℹ️ About these Notes**`r`n> These notes comprehensively detail encryption algorithms, cryptography applications like PKI, various cryptanalysis methods, and emerging threats from quantum computing. **No attack methodologies, OWASP risks, or specific exploit concepts have been omitted**, ensuring this document remains a complete, comprehensive resource for exam preparation.';
        'Name' = 'Module 20: Cryptography'
    }
}

$baseDir = 'd:\CEH-Certification\Certified-Ethical-Hacker-v13'

foreach ($mod in $mods.Keys) {
    $dir = Join-Path $baseDir $mod
    $files = Get-ChildItem -Path $dir -Filter '*.md' | Sort-Object Name
    $aboutText = $mods[$mod]['About']
    $modName = $mods[$mod]['Name']
    
    for ($i=0; $i -lt $files.Count; $i++) {
        $file = $files[$i]
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Replace the generic/broken "About these Notes" with the module-specific one
        $genericPattern = '(?s)> \*\*(.)\1 About these Notes\*\*.*?preparation\.'
        $content = $content -replace $genericPattern, $aboutText
        
        $genericPattern2 = '(?s)> \*\*.*? About these Notes\*\*.*?preparation\.'
        $content = $content -replace $genericPattern2, $aboutText
        
        # Remove any existing footer to prevent duplicates if we re-run
        $content = $content -replace '(?s)\r?\n---\r?\n\r?\n\*\s*📚 CEH v13.*', ''
        
        # Create footer
        $currentName = $file.BaseName
        $footer = "`r`n`r`n---`r`n`r`n*📚 CEH v13 · $modName | $currentName"
        
        if ($i -gt 0) {
            $prevName = $files[$i-1].BaseName
            $footer += " | Prev: $prevName"
        }
        if ($i -lt ($files.Count - 1)) {
            $nextName = $files[$i+1].BaseName
            $footer += " | Next: $nextName"
        }
        $footer += "*"
        
        $content += $footer
        Set-Content -Path $file.FullName -Value $content -NoNewline -Encoding UTF8
    }
}
echo 'Updates applied.'
