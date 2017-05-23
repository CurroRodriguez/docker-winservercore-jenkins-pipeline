FROM microsoft/windowsservercore
SHELL ["powershell", "-NoProfile", "-command"]
RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted

# === mingw ===
RUN mkdir c:\install
RUN (new-object system.net.webclient).DownloadFile('https://freefr.dl.sourceforge.net/project/mingw/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip', 'c:\install\mingw.zip')
RUN Expand-Archive -Path C:\install\mingw.zip -DestinationPath c:\mingw
RUN c:\mingw\bin\mingw-get.exe update

# === msys ===
RUN c:\mingw\bin\mingw-get.exe install bash msys-vim msys-openssh msys-findutils msys-coreutils

# === git ===
RUN (new-object system.net.webclient).DownloadFile('https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/Git-1.9.5-preview20150319.exe', 'c:\install\git-1.9.5.exe')
RUN c:\install\git-1.9.5.exe /SILENT
ENV HOME="c:\Users\ContainerAdministrator"

# === PATH ===
RUN $path = $env:path + ';c:\mingw\bin;c:\mingw\msys\1.0\bin;c:\Program Files (x86)\Git\bin'; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $path
SHELL ["cmd", "/S", "/C"]

# === bash ===
COPY bashrc C:\\Users\\ContainerAdministrator\\.bashrc
COPY entrypoint.cmd C:\\entrypoint.cmd

# ready
WORKDIR C:\\Users\\ContainerAdministrator
ENTRYPOINT ["c:/entrypoint.cmd"]

CMD c:\\Windows\\System32\\cmd.exe
