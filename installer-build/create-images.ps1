Add-Type -AssemblyName System.Drawing

# === Large Wizard Image (164x314) - Left panel ===
$bmp = New-Object System.Drawing.Bitmap(164, 314)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.TextRenderingHint = 'AntiAlias'

# Gradient background
$rect = New-Object System.Drawing.Rectangle(0, 0, 164, 314)
$brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.ColorTranslator]::FromHtml("#0E8A45"), [System.Drawing.ColorTranslator]::FromHtml("#021A0D"), [System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
$g.FillRectangle($brush, $rect)

# Circuit-like grid pattern
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 74, 232, 140), 1)
$pen.DashStyle = 'Dot'
for ($i = 30; $i -lt 300; $i += 25) { $g.DrawLine($pen, 10, $i, 154, $i) }
for ($j = 20; $j -lt 164; $j += 25) { $g.DrawLine($pen, $j, 30, $j, 280) }

# Accent nodes at intersections
$nodeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#4AE88C"))
$rnd = New-Object System.Random(42)
for ($i = 0; $i -lt 15; $i++) {
    $x = $rnd.Next(15, 149); $y = $rnd.Next(40, 270); $size = $rnd.Next(3, 7)
    $g.FillEllipse($nodeBrush, $x, $y, $size, $size)
}

# Shield icon
$shieldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#4AE88C"))
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddArc(52, 50, 60, 50, 180, 180)
$path.AddLine(112, 75, 112, 110)
$path.AddLine(112, 110, 82, 130)
$path.AddLine(82, 130, 52, 110)
$path.AddLine(52, 110, 52, 75)
$path.CloseFigure()
$g.FillPath($shieldBrush, $path)

# Checkmark inside shield
$checkPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#021A0D"), 3)
$g.DrawLine($checkPen, 68, 90, 78, 102)
$g.DrawLine($checkPen, 78, 102, 96, 78)

# Glow effect around shield
$glowPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 74, 232, 140), 2)
$pathGlow = New-Object System.Drawing.Drawing2D.GraphicsPath
$pathGlow.AddArc(48, 46, 68, 58, 180, 180)
$pathGlow.AddLine(116, 75, 116, 114)
$pathGlow.AddLine(116, 114, 82, 136)
$pathGlow.AddLine(82, 136, 48, 114)
$pathGlow.AddLine(48, 114, 48, 75)
$pathGlow.CloseFigure()
$g.DrawPath($glowPen, $pathGlow)

# "LindAV" text
$fontBold = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = 'Center'
$g.DrawString("LindAV", $fontBold, $whiteBrush, 82, 145, $sf)

# "Security Suite" subtitle
$fontSub = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$accentBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#4AE88C"))
$g.DrawString("Security Suite", $fontSub, $accentBrush, 82, 170, $sf)

# Decorative hex pattern bottom area
$hexPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(50, 74, 232, 140), 1)
for ($row = 0; $row -lt 4; $row++) {
    for ($col = 0; $col -lt 5; $col++) {
        $cx = 20 + $col * 30 + ($row % 2) * 15
        $cy = 200 + $row * 22
        $hexPath = New-Object System.Drawing.Drawing2D.GraphicsPath
        for ($k = 0; $k -lt 6; $k++) {
            $angle = [Math]::PI / 3 * $k - [Math]::PI / 6
            $px = $cx + 10 * [Math]::Cos($angle)
            $py = $cy + 10 * [Math]::Sin($angle)
            if ($k -eq 0) { $startX = $px; $startY = $py }
            else { $hexPath.AddLine($lastX, $lastY, $px, $py) }
            $lastX = $px; $lastY = $py
        }
        $hexPath.AddLine($lastX, $lastY, $startX, $startY)
        $g.DrawPath($hexPen, $hexPath)
    }
}

# "by JERMAN" brand at bottom
$fontBrand = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$mutedBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(140, 255, 255, 255))
$g.DrawString("by JERMAN", $fontBrand, $mutedBrush, 82, 278, $sf)
$fontSmall = New-Object System.Drawing.Font("Segoe UI", 7, [System.Drawing.FontStyle]::Regular)
$g.DrawString("v1.0.0", $fontSmall, $mutedBrush, 82, 295, $sf)

$g.Dispose()
$bmp.Save("$PSScriptRoot\wizard-image.bmp", [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmp.Dispose()
Write-Host "Large wizard image created"

# === Small Header Image (55x58) ===
$bmpS = New-Object System.Drawing.Bitmap(55, 58)
$gS = [System.Drawing.Graphics]::FromImage($bmpS)
$gS.SmoothingMode = 'AntiAlias'

$rectS = New-Object System.Drawing.Rectangle(0, 0, 55, 58)
$brushS = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rectS, [System.Drawing.ColorTranslator]::FromHtml("#0E8A45"), [System.Drawing.ColorTranslator]::FromHtml("#021A0D"), [System.Drawing.Drawing2D.LinearGradientMode]::ForwardDiagonal)
$gS.FillRectangle($brushS, $rectS)

# Mini shield
$pathS = New-Object System.Drawing.Drawing2D.GraphicsPath
$pathS.AddArc(12, 8, 30, 25, 180, 180)
$pathS.AddLine(42, 21, 42, 38)
$pathS.AddLine(42, 38, 27, 50)
$pathS.AddLine(27, 50, 12, 38)
$pathS.AddLine(12, 38, 12, 21)
$pathS.CloseFigure()
$shieldBrushS = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#4AE88C"))
$gS.FillPath($shieldBrushS, $pathS)

# Mini checkmark
$checkPenS = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#021A0D"), 2)
$gS.DrawLine($checkPenS, 21, 30, 26, 37)
$gS.DrawLine($checkPenS, 26, 37, 36, 22)

$gS.Dispose()
$bmpS.Save("$PSScriptRoot\wizard-small.bmp", [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmpS.Dispose()
Write-Host "Small header image created"
