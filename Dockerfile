# Use a Windows base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Download and install Ngrok
RUN powershell -Command Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "ngrok.zip" ; \
    Expand-Archive -Path "ngrok.zip" -DestinationPath "C:\ngrok"

# Set Ngrok authentication token as an environment variable
ENV NGROK_AUTH_TOKEN="1wOBiyieGdM0TEoffSyszMYCfnL_56xVrqJRj9sZj3Y7FxdpS"

# Enable Terminal Server
RUN powershell -Command Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0 ; \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop" ; \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1 ; \
    Set-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "P@ssw0rd!" -Force)

# Expose Ngrok tunnel
EXPOSE 3389

# Start Ngrok tunnel
CMD ["C:\\ngrok\\ngrok.exe", "tcp", "3389"]
