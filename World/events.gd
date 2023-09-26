extends Node
# also set autoload in the project setting, dont forget to import/add to current
#signal player_died

#step 
#1 add signal here for singleton
#2 where to emit signal: Events.signalname.emit(param)
#3 where to receive signal: Events.signalname.connect(function_name)
#4 create function within the same name as function_name in the same gdscript
signal hit_checkpoint(checkpoint_pos)
signal player_died()


#or custom signal
#singal          signal player_died_signal()    can put para in ()
#emit singal from the same location     player_died_signal.emit(param)
#link node to where to reived the signal, create a new function in the new gd script
#add logic to the new function  
