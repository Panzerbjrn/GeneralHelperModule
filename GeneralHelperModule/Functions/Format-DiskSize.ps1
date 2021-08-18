Function Format-DiskSize
{
	param ($size)
	Switch ($size)
	{
		{$_ -ge 1PB}{"{0:#.#'Pb'}" -f ($size / 1PB);	Break}
		{$_ -ge 1TB}{"{0:#.#'Tb'}" -f ($size / 1TB);	Break}
		{$_ -ge 1GB}{"{0:#.#'Gb'}" -f ($size / 1GB);	Break}
		{$_ -ge 1MB}{"{0:#.#'Mb'}" -f ($size / 1MB);	Break}
		{$_ -ge 1KB}{"{0:#'Kb'}" -f ($size / 1KB);	Break}
		default {"{0}" -f ($size) + "B"}
	}
}