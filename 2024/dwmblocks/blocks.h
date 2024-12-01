// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "~/.local/bin/cmus_status", 5, 0},
    {"", "~/.local/bin/temperature", 30, 0},
    {"", "~/.local/bin/utilization", 15, 0},
    {"", "~/.local/bin/memory", 15, 0},
    {"", "~/.local/bin/update", 300, 0},
    {"", "~/.local/bin/pacman", 300, 0},
    {"", "~/.local/bin/volume", 0, 10},
    {"", "~/.local/bin/time", 60, 0},
    {"", "~/.local/bin/internet", 60, 0},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = "|";
static unsigned int delimLen = 5;
