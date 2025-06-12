Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$scriptDir = $PSScriptRoot

$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)

$filename = Join-Path -Path $scriptDir -ChildPath "Screenshot\DW_$((Get-Date).ToString('yyyy-MM-dd_HH.mm.ss')).png"
$bmp.Save($filename, [System.Drawing.Imaging.ImageFormat]::Png)