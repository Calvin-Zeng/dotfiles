# C.L. Zeng’s dotfiles

It's just a dotfile for myself used.  
I also write an install script to deploy workspace environment, if you give these dotfiles a try, Please fork this repository.

## Installation

**Warning:** Plaese review the [Install.sh](Install.sh)/[Install-stow.sh](Install-stow.sh) before perform it.  
  
There are two method to install this dotfiles, One is use Gnu stow, another is the normal file/symbolic link check mechanism.  

```bash
cd ~
git clone --recurse-submodules https://github.com/Calvin-Zeng/dotfiles.git && cd dotfiles
```

### Use the Gnu stow

If you use this way, I suggest the dotfiles need placed at $HOME,  
then please remove the annotated line which you want to deploy part.  

```bash
sh Install-stow.sh
```

### Normal file/symbolic link check

The script will check the dotfiles which previously existed,  
if the file type is 'file', then backup to the Backup folder.  
or the file type is 'symbolic link', it will detemeter the real path, then ask action to you.  

```bash
sh Install.sh
```

### Custom setting for yourself.

You can easily set the specific configuration for yourself want.  
In the [.extra](bash_library/.extra.example) file, it's a example template.  
Modify this file and copy to $HOME/.extra, then it will load-in during terminal bootstrap.  

## Dependencies tools Installation

Once you finished the dotfiles installed, The dotfiles depend some tools.(like:
[fzf](https://github.com/junegunn/fzf),
[tmux](https://github.com/tmux/tmux),
[Midnight Commander](https://github.com/MidnightCommander/mc)
)

**I prefer you install tools by root if you have root access privileges.**  
  
otherwise, I have had wrote some script to easily deploy them without root access. change to bootstrap_script folder and perform script.  
:information_source: The dotfiles will check dependent tools is present,If you don't install these tools, It will skip some bash code, everything is works fine!  

```bash
cd bootstrap_script
./Install_bat.sh
./Install_fzf.sh
./Install_grv.sh
./Install_icdiff.sh
./Install_sublime.sh

cd bootstrap_script/Install_tmux.sh/
./tmux_local_install.sh

cd bootstrap_script/Install_mc.sh/
./mc_local_install.sh
```

[License](LICENSE)
------------------

The MIT License (MIT)

Copyright (c) 2022 C.L. Zeng
