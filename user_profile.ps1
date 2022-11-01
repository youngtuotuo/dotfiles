Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History

# Alias
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

function l { ls | Format-Wide -Column 3 }

function which ($command) {
        Get-Command -Name $command -ErrorAction SilentlyContinue |
          Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function export($name, $value) {
	set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
	get-process $name -ErrorAction SilentlyContinue | stop-process
}

function touch($file) {
	if ( Test-Path $file ) {
		Set-FileTime $file
	} else {
		New-Item $file -type file
	}
}

function ln($target, $link) {
	New-Item -ItemType SymbolicLink -Path $link -Value $target
}

set-alias new-link ln

function grep($regex, $dir) {
	if ( $dir ) {
		get-childitem $dir | select-string $regex
		return
	}
	$input | select-string $regex
}

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
