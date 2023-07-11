Invoke-WebRequest -Uri "https://dl.dropboxusercontent.com/s/8hfx7cp4xn0jt5s/wget.exe" -UseBasicParsing -OutFile "wget.exe"

Start-Process -FilePath 'cmd.exe' -ArgumentList '/c dir'