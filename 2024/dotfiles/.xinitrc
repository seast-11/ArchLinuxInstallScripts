# To avoid screen tearing
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }" &

# Randomly pick a wallpaper from ~/Wallpapers
RANDOM_WALLPAPER=$(find ~/Wallpapers -type f | shuf -n 1)

# Set wallpaper and generate colors
wal -i "$RANDOM_WALLPAPER" &
xwallpaper --zoom "$RANDOM_WALLPAPER"

# Apply colors to Xresources 
xrdb -merge ~/.cache/wal/colors.xresources

# Start picom for window effects
picom --animations &

# Start dwmblocks for status bar
dwmblocks &

# Start DWM and log errors
while true; do
    dwm 2> ~/.cache/.dwm.log
done

