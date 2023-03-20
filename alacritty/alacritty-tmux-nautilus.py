# Alacritty Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restart Nautilus, and enjoy :)
#
# This script is released to the public domain.
#
# Source: https://github.com/GaoYuCan/alacritty-nautilus


from gi.repository import Nautilus, GObject
from subprocess import call

# path to alacritty
ALACRITTY = 'alacritty'

# what name do you want to see in the context menu?
ALACRITTYNAME = 'Alacritty'


class AlacrittyExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_alacritty(self, menu, file):
        safepaths = '"' + file.get_location().get_path() + '" '
        call(ALACRITTY + ' --working-directory ' + safepaths + ' -e tmux ' + '&', shell=True)

    def get_background_items(self, *args):
        cfile_ = args[-1]
        item = Nautilus.MenuItem(
            name='AlacrittyOpenBackground',
            label='Abrir no ' + ALACRITTYNAME,
            tip='Abrir o diretório atual no Alacritty')
        item.connect('activate', self.launch_alacritty, cfile_)

        return [item]