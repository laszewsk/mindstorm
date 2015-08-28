def banner(txt=None, c="#", debug=True):
    """prints a banner of the form with a frame of # arround the txt::
      ############################
      # txt
      ############################
    .
    :param txt: a text message to be printed
    :type txt: string
    :param c: the character used instead of c
    :type c: character
    """
    if debug:
        print
        print "#", 70 * c
        if txt is not None:
            print "#", txt
            print "#", 70 * c

