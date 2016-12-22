#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

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


    retour = lua_dofile( state, "hello.lua" );
    if( !retour ) {
        lua_getglobal(state, "MaFonctionLua");
        lua_pushnumber(state, 11);
        lua_pushnumber(state, 42);
        lua_pcall(state, 2, 1, 0);
        if(lua_isnumber(state, -1)) {
            printf("Retour : %d\n", (int)lua_tonumber(state, -1));
        }
        lua_pop(state, 1);
    }

    lua_close (state);
    
    return 0;
}
