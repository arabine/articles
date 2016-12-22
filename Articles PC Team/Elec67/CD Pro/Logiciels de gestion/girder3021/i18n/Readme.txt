Internationalization Tools version 0.3
Copyright (c) 2000 Ron Bessems
GNU General Public License.

( If the program INTERNAT.EXE isn't in this directory 
  you need to download the internationalization tools 
  from my homepage in the Girder section
  http://www.stack.nl/~stilgar )



Description
-----------
   Internationalization Tools (for short i18n) is a set of Delphi
   sources that allow you to make your programs easily translatable
   via external language files. So users can contribute translations
   to your program. The program internat allows users to translate to
   their own language.
   
   Mind though this program is in it's early stages of developement.
   It's usable but just to be sure backup your language files before
   changing them.

   Please make sure that Internat.exe is in the same directory as the
   language files.

Usage INTERNAT.
---------------
A. New Translation.
    
   * To make a new translation type the name of your language in the
   language dropdownbox (middle of the window).
   * Press the "Refresh translatables". Internat now loads all 
   translatable strings from english.lng.
   * Click on the first translatable string in the listbox (left side) 
   * Now in the top two editboxes appear the same strings.
   * You must change the lower sentence (Translate box)
   * Press enter when you finish with a translation
   * The next string will automatically be selected.
   * When you're ready translating press the "save translation" button.
   * In the application (in this case Girder) set the language 
   to the name you specified here.

B. Update a Translation.

   Do this if you translated the application (int this case Girder) 
   and the program changed some of it's translations. Or added translations

   * First of all set the language box to your language. (middle of the window).
   * Press "Load translation"
   * Now we want the new translations to be loaded and the stale ones
   removed. So press "Refresh Translatables"
   * The new strings have been added to the list.
   * Translate them as usual and save your file.


  