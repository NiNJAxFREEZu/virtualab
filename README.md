# inz-scripts
Zestaw skryptów pozwalających na automatyczną konfigurację maszyny wirtualnej do laboratorium.

# Użycie
## Systemy GNU/Linux
```bash
curl -LO https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/[NAZWA_SKRYPTU]

sudo bash [NAZWA_SKRYPTU]
```


## Systemy Windows 8.1/10/Server
Poniższe polecenia należy *koniecznie* wykonać w powłoce **PowerShell** z podniesionymi uprawnieniami (**aka** uruchomić ją jako administrator).
1. W pierwszej kolejności należy włączyć możliwość wykonywania skryptów powłoki PowerShell za pomocą polecenia:

```powershell
Set-ExecutionPolicy RemoteSigned
```
Dotyczy to w szczególności systemów w wersji *Home*.

2. Następnie należy pobrać i uruchomić wybrany skrypt z repozytorium:
```powershell
Invoke-WebRequest https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/[NAZWA_SKRYPTU] -OutFile install.ps1

.\install.ps1
```

## Sieciowe katalogi domowe
### Systemy GNU/Linux
```bash
sudo bash dysk_ubuntu.sh [LOGIN] [PASSWORD]
```
