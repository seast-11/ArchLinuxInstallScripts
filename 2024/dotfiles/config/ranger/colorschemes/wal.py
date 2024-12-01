import os
import json
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import normal, bold, reverse, default_colors


class WalColorScheme(ColorScheme):
    progress_bar_color = 13  # Example color index for the progress bar

    def __init__(self):
        super().__init__()
        self.colors = {}
        self.load_colors()

    def load_colors(self):
        """Load Pywal colors from the generated colors.json file."""
        colors_file = os.path.expanduser("~/.cache/wal/colors.json")
        if os.path.exists(colors_file):
            with open(colors_file, "r") as f:
                colors = json.load(f)
                self.colors = {k: v for k, v in colors.items()}
        else:
            raise FileNotFoundError("Pywal colors.json not found! Run pywal first.")

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        # Apply Pywal colors based on the context
        if context.in_browser:
            fg, bg, attr = self.verify_browser(context, fg, bg, attr)

        elif context.in_titlebar:
            fg, bg, attr = self.verify_titlebar(context, fg, bg, attr)

        elif context.in_statusbar:
            fg, bg, attr = self.verify_statusbar(context, fg, bg, attr)

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            fg, bg, attr = self.verify_taskview(context, fg, bg, attr)

        if context.vcsfile and not context.selected:
            fg, bg, attr = self.verify_vcsfile(context, fg, bg, attr)

        elif context.vcsremote and not context.selected:
            fg, bg, attr = self.verify_vcsremote(context, fg, bg, attr)

        return fg, bg, attr

    def verify_browser(self, context, fg, bg, attr):
        """Set colors for different states in the file browser."""
        if context.selected:
            attr = reverse
        else:
            attr = normal

        if context.empty or context.error:
            bg = self.colors.get("color1", 1)  # error color
            fg = self.colors.get("color0", 0)  # black color
        if context.border:
            fg = self.colors.get("color8", 8)  # border color
        if context.document:
            fg = self.colors.get("color13", 13)  # document color
        if context.container:
            attr |= bold
            fg = self.colors.get("color9", 9)  # container color
        if context.directory:
            attr |= bold
            fg = self.colors.get("color4", 4)  # directory color
        elif context.executable:
            attr |= bold
            fg = self.colors.get("color2", 2)  # executable color
        if context.link:
            fg = self.colors.get("color6", 6) if context.good else self.colors.get("color13", 13)
        if context.tag_marker and not context.selected:
            attr |= bold
            fg = self.colors.get("color7", 7)  # tag marker color

        return fg, bg, attr

    def verify_titlebar(self, context, fg, bg, attr):
        """Set colors for the titlebar."""
        attr |= bold
        if context.hostname:
            fg = self.colors.get("color1", 1) if context.bad else self.colors.get("color2", 2)
        elif context.directory:
            fg = self.colors.get("color4", 4)
        elif context.tab:
            if context.good:
                bg = self.colors.get("color2", 2)
        elif context.link:
            fg = self.colors.get("color6", 6)

        return fg, bg, attr

    def verify_statusbar(self, context, fg, bg, attr):
        """Set colors for the statusbar."""
        if context.permissions:
            fg = self.colors.get("color2", 2) if context.good else self.colors.get("color8", 8)
        if context.marked:
            attr |= bold | reverse
            fg = self.colors.get("color3", 3)
        if context.frozen:
            attr |= bold | reverse
            fg = self.colors.get("color6", 6)
        if context.message:
            if context.bad:
                attr |= bold
                fg = self.colors.get("color1", 1)
        if context.loaded:
            bg = self.progress_bar_color  # Use the progress bar color
        if context.vcsinfo:
            fg = self.colors.get("color4", 4)
            attr &= ~bold
        if context.vcscommit:
            fg = self.colors.get("color3", 3)
            attr &= ~bold
        if context.vcsdate:
            fg = self.colors.get("color6", 6)
            attr &= ~bold

        return fg, bg, attr

    def verify_taskview(self, context, fg, bg, attr):
        """Set colors for the taskview."""
        if context.title:
            fg = self.colors.get("color4", 4)

        if context.selected:
            attr |= reverse

        if context.loaded:
            if context.selected:
                fg = self.progress_bar_color
            else:
                bg = self.progress_bar_color

        return fg, bg, attr

    def verify_vcsfile(self, context, fg, bg, attr):
        """Set colors for VCS (version control system) files."""
        attr &= ~bold
        if context.vcsconflict:
            fg = self.colors.get("color5", 5)
        elif context.vcschanged:
            fg = self.colors.get("color1", 1)
        elif context.vcsunknown:
            fg = self.colors.get("color1", 1)
        elif context.vcsstaged:
            fg = self.colors.get("color2", 2)
        elif context.vcssync:
            fg = self.colors.get("color2", 2)
        elif context.vcsignored:
            fg = default

        return fg, bg, attr

    def verify_vcsremote(self, context, fg, bg, attr):
        """Set colors for remote VCS files."""
        attr &= ~bold
        if context.vcssync or context.vcsnone:
            fg = self.colors.get("color2", 2)
        elif context.vcsbehind:
            fg = self.colors.get("color1", 1)
        elif context.vcsahead:
            fg = self.colors.get("color6", 6)
        elif context.vcsdiverged:
            fg = self.colors.get("color5", 5)
        elif context.vcsunknown:
            fg = self.colors.get("color1", 1)

        return fg, bg, attr

