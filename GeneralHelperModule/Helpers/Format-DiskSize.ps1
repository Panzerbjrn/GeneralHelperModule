Function Format-DiskSize {
    param ($size)
    switch ($size) {
        {$_ -ge 1PB} { "{0:0.#}PB" -f ($size / 1PB); break }
        {$_ -ge 1TB} { "{0:0.#}TB" -f ($size / 1TB); break }
        {$_ -ge 1GB} { "{0:0.#}GB" -f ($size / 1GB); break }
        {$_ -ge 1MB} { "{0:0.#}MB" -f ($size / 1MB); break }
        {$_ -ge 1KB} { "{0:0}KB" -f ($size / 1KB); break }
        default      { "{0}B" -f $size }
    }
}
