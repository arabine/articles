#include <stdio.h>
#include <lua.h>
 
int main(int argc, char* argv[ ])
{
    lua_State* state = lua_open();
    
    if ( state == NULL )
    {
        printf("Erreur pendant l'initialisation de Lua\n");
        return -1;
    }
    
    /* suite du code ... */
    
    lua_close (state);
    
    
    return 0;
}
