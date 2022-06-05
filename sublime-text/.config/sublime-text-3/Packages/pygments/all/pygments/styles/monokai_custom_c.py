# -*- coding: utf-8 -*-
"""
    pygments.styles.monokai
    ~~~~~~~~~~~~~~~~~~~~~~~

    Mimic the Monokai color scheme. Based on tango.py.

    http://www.monokai.nl/blog/2006/07/15/textmate-color-theme/

    :copyright: Copyright 2006-2015 by the Pygments team, see AUTHORS.
    :license: BSD, see LICENSE for details.
"""

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Text, \
     Number, Operator, Generic, Whitespace, Punctuation, Other, Literal

class MonokaiCustom_C_Style(Style):
    """
    This style mimics the Monokai color scheme.
    Use #e6e6e6 to adjust color
    https://www.w3schools.com/colors/colors_hsl.asp
    https://www.w3schools.com/colors/colors_picker.asp
    """

    background_color = "#272822"
    highlight_color = "#49483e"

    styles = {
        # No corresponding class for the following:
        Text:                      "",        # class:  ''
        Whitespace:                "",        # class: 'w'
        Error:                     "",        # class: 'err'
        Other:                     "",        # class 'x'

        Comment:                   "#75715e", # class: 'c' - OK
        Comment.Multiline:         "",        # class: 'cm'
        Comment.Preproc:           "",        # class: 'cp'
        Comment.Single:            "",        # class: 'c1'
        Comment.Special:           "",        # class: 'cs'

        Keyword:                   "#f92672", # class: 'k' - OK
        Keyword.Constant:          "",        # class: 'kc'
        Keyword.Declaration:       "",        # class: 'kd'
        Keyword.Namespace:         "",        # class: 'kn'
        Keyword.Pseudo:            "",        # class: 'kp'
        Keyword.Reserved:          "",        # class: 'kr'
        Keyword.Type:              "#16b1d0", # class: 'kt' - OK

        Operator:                  "",        # class: 'o'
        Operator.Word:             "",        # class: 'ow' - like keywords

        Punctuation:               "",        # class: 'p'

        Name:                      "",        # class: 'n'
        Name.Attribute:            "",        # class: 'na' - to be revised
        Name.Builtin:              "#7a33ff", # class: 'nb' - OK
        Name.Builtin.Pseudo:       "",        # class: 'bp'
        Name.Class:                "",        # class: 'nc' - to be revised
        Name.Constant:             "",        # class: 'no' - to be revised
        Name.Decorator:            "",        # class: 'nd' - to be revised
        Name.Entity:               "",        # class: 'ni'
        Name.Exception:            "",        # class: 'ne'
        Name.Function:             "#80b418", # class: 'nf' - OK
        Name.Property:             "",        # class: 'py'
        Name.Label:                "",        # class: 'nl'
        Name.Namespace:            "",        # class: 'nn' - to be revised
        Name.Other:                "",        # class: 'nx'
        Name.Tag:                  "",        # class: 'nt' - like a keyword
        Name.Variable:             "",        # class: 'nv' - to be revised
        Name.Variable.Class:       "",        # class: 'vc' - to be revised
        Name.Variable.Global:      "",        # class: 'vg' - to be revised
        Name.Variable.Instance:    "",        # class: 'vi' - to be revised

        Number:                    "#ae81ff", # class: 'm' - OK
        Number.Float:              "",        # class: 'mf'
        Number.Hex:                "",        # class: 'mh'
        Number.Integer:            "",        # class: 'mi'
        Number.Integer.Long:       "",        # class: 'il'
        Number.Oct:                "",        # class: 'mo'

        Literal:                   "",        # class: 'l'
        Literal.Date:              "",        # class: 'ld'

        String:                    "#998c1a", # class: 's' - OK - Same Literal?
        String.Backtick:           "",        # class: 'sb'
        String.Char:               "",        # class: 'sc'
        String.Doc:                "",        # class: 'sd' - like a comment
        String.Double:             "",        # class: 's2'
        String.Escape:             "",        # class: 'se'
        String.Heredoc:            "",        # class: 'sh'
        String.Interpol:           "",        # class: 'si'
        String.Other:              "",        # class: 'sx'
        String.Regex:              "",        # class: 'sr'
        String.Single:             "",        # class: 's1'
        String.Symbol:             "",        # class: 'ss'

        Generic:                   "",        # class: 'g'
        Generic.Deleted:           "",        # class: 'gd',
        Generic.Emph:              "italic",  # class: 'ge'
        Generic.Error:             "",        # class: 'gr'
        Generic.Heading:           "",        # class: 'gh'
        Generic.Inserted:          "",        # class: 'gi'
        Generic.Output:            "",        # class: 'go'
        Generic.Prompt:            "",        # class: 'gp'
        Generic.Strong:            "bold",    # class: 'gs'
        Generic.Subheading:        "",        # class: 'gu'
        Generic.Traceback:         "",        # class: 'gt'
    }
