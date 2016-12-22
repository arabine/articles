#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

static int poeme( lua_State *state )
{
    int n = lua_gettop(state);  /* nombre d'arguments */
    int i;
    
    for( i=1; i <= n; i++) {
        if( lua_isstring(state, i) ) {
            printf( "%s\n", (char*)lua_tostring(state, i) );
        }
    }
    lua_pushstring(state, "\n\nSaint John Perse\n" );
    
    return 1;  /* nombre de résultats dans la pile */
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
    
    lua_register(state, "poeme", poeme);
    lua_dofile( state, "hello.lua" );
    
    lua_close (state);
    
    return 0;
}
