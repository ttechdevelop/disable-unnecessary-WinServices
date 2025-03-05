# список служб
$services = @(
    "Downloaded Maps Manager",               # Диспетчер загруженных карт
    "Xbox Live Auth Manager",                # Службы, связанные с Xbox
    "Xbox Live Game Save",                   # Службы, связанные с Xbox
    "Xbox Live Networking Service",          # Службы, связанные с Xbox
    "Windows Insider Service",               # Служба программы предварительной оценки Windows
    "RetailDemo",                            # Служба демонстрации розничных продаж
    "DiagTrack",                             # Служба подключенных пользователей и телеметрии
    "TabletInputService",                    # Служба ввода планшетного ПК
    "lfsvc",                                 # Служба геолокации
    "WbioSrvc",                              # Биометрическая служба Windows
    "NetBT",                                 # NetBIOS через TCP/IP
    "vmms",                                  # Службы, связанные с Hyper-V
    "DoSvc"                                  # Оптимизация доставки обновлений Windows
)

# функция для остановки и отключения службы
function Disable-Service {
    param([string]$serviceName) # определяем параметры функции

    # проверяем, существует ли служба
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service) { # проверка есть ли служба
	
        # Останавливаем службу, если она запущена
        if ($service.Status -eq "Running") {
            Write-Host "Stopping service: $serviceName"
            Stop-Service -Name $serviceName -Force
        }
        
        # отключаем службу
        Write-Host "Disabling service: $serviceName"
        Set-Service -Name $serviceName -StartupType Disabled  # предотвращаем запуск при перезагрузке
    } else {
        Write-Host "Service $serviceName not found or already disabled."
    }
}

# Отключение всех перечисленных служб
foreach ($service in $services) {
    Disable-Service -serviceName $service
}

Write-Host "All specified services have been processed."