# CBoard++
Open source customized iOS keyboard extension integrated with accessibility features tailored to C++ programming.


# THE IMPORTANCE OF SMART KEYBOARDS

What is a smart keyboard? By my definition, it is a keyboard that uses artificial intelligence, computation, and logic to make typing as easy as possible. Some people like typing, or more importantly, are good at it. However, if one does not have the physical ability to move one’s fingers simultaneously, how would one type efficiently on a normal keyboard? How would one type efficiently if one can only type with a single finger at a time? That is where this application comes in. Much like xkeys, it is a specialized interface to make typing easier for its intended audience; that audience being people who do not use a normal keyboard under any circumstances, like Brad. However, unlike xkeys, this keyboard is specifically tailored to coding.


# INTENT

The intent of this application is to make coding easier for this audience and to eliminate the requirement of a scribe. With regards to the individual designed tailored to Brad’s characteristics, it is intended to help him continue pursuing computer science. With all the challenges Brad faces, it is important to make this application flexible and to make it not require a lot of physical effort, as he does not have movement in both legs and one arm. For Brad, being able to open this application and work on a project without the help of a scribe to write code is my goal for this project.

# FEATURES

The features of this application will hopefully make writing code more efficient. I envision having different branches of the keyboard, neatly formatted from the “origin” keyboard. Each branch represents another keyboard. The branches I imagine will include datatypes, C++ libraries, previously declared variable names, previously declared function names, as well as miscellaneous C++ functionality such as loops and containers like vectors and queues. These features will be available to the user from the origin keyboard.

These features are meant to speed up the coding process for any user who wants to program on an iOS device. It is meant to be equitable and flexible in this sense. However, the production of this application will be tailored to Brad’s needs. The features are meant to make programming for him not only bearable but also efficient. Brad’s specific needs will be fulfilled by this application. With only having one hand to type, this interface will be similar to the xkeys inteface that he feels comfortable with.

# DESIGN

From this point on, 'CBoard' will refer to the iOS custom keyboard extension this repository supplies. The software design will stem from an “origin” CBoard. This “origin” CBoard is the base class for which all the features and functionality stem from. Each subsequent CBoard inherits from this origin CBoard and can be reached from that origin CBoard. On the application’s boot-up, the user sees the origin CBoard with keys that lead to the more feature-specific CBoard.

The specific CBoards featured allow for:

  -Creation of Data Containers
  
  -Creation of variables & functions
  
  -Stored variables & functions
  
  -Creation of loops
  
  -Importing libraries (in name only)
  
  -Creation of custom data types
  
  -Storage of custom data types

# CONCLUSION

This application is meant to help Brad by being simple and intuitive. It is intended to assist users who are interested in programming but cannot use traditional ways of coding. Designing this application specifically for Brad may uncover a better understanding of why smart keyboards are growing more important universally.
