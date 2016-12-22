#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

static int erreurLua(lua_State *state)
{
    int n = lua_gettop(state);
    if( n ) {
        printf("Erreur Lua : %s\n", (char*)lua_tostring(state, n) );
    }
    return 0;
}


int main(int argc, char* argv[ ])
{
    int retour;
    
    lua_State* state = lua_open();
    
    if ( state == NULL )
    {
        printf("Erreur pendant l'initialisation de Lua\n");
        return -1;
    }
    
    lua_baselibopen( state );
    
    /* Quelques bibliothèques optionnelles supplémentaires */
    luaopen_io( state );
    luaopen_table( state );
    luaopen_string( state );
    luaopen_math( state );
    luaopen_debug( state );
    
    lua_register(state, "_ALERT", erreurLua);
    lua_dofile( state, "hello.lua" );
    
    lua_close (state);
    
    return 0;
}
