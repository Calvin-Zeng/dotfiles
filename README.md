# C.L Zeng’s dotfiles

It's just a dotfile for myself used.  
I also write an Install.sh for the deploy workspace phases, if you give these dotfiles a try, Please fork this repository.

## Installation

**Warning:** Plaese review the Install.sh before perform it.  
  
The script will check the dotfiles which previously existed,  
if the file type is 'file', then backup to the Backup folder.  
or the file type is 'symbolic link', it will detemeter the real path, then ask action to you.  

```bash
git clone https://github.com/Calvin-Zeng/dotfiles.git && cd dotfiles && sh Install.sh
```

## Dependencies tools Installation

Once you finished the dotfiles installed, The dotfiles depend some tools.(like:
[fzf](https://github.com/junegunn/fzf),
[tmux](https://github.com/tmux/tmux)
)

**I prefer you install tools by root if you have root access privileges.**  
  
otherwise, I have had wrote some script to easily deploy them without root access. change to bootstrap_script folder and perform script.  
:information_source: The dotfiles will check dependent tools is present,If you don't install these tools, It will skip some bash code, everything is works fine!  

```bash
cd bootstrap_script
./Install_fzf.sh
./Install_grv.sh

cd bootstrap_script/Install_tmux.sh/
./tmux_local_install.sh

cd bootstrap_script/Install_mc.sh/
./mc_local_install.sh
```

[License](LICENSE)
------------------

The MIT License (MIT)

Copyright (c) 2022 C.L. Zeng
