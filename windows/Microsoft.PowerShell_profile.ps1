Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ InlinePrediction = "$([char]0x1b)[38;5;238m" }

Set-Alias vi nvim
Set-Alias ls lsd
function ll($name) { lsd -Alh }
function la($name) { lsd -AF }
function l($name) { lsd -lF }
function pkill($name) { get-process $name -ErrorAction SilentlyContinue | stop-process }

function find-file($name) {
	get-childitem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | foreach-object {
		write-output($PSItem.FullName)
	}
}

set-alias find find-file
set-alias find-name find-file

function reboot {
	shutdown /r /t 0
}
function dev($name) {
    $curDir = Get-Location;
    C:\'Program Files\Microsoft Visual Studio'\2022\Community\Common7\Tools\Launch-VsDevShell.ps1 -Arch amd64;
    cd $curDir
}
