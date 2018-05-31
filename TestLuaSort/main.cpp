//
//  main.cpp
//  TestLuaSort
//
//  Created by Alex Usachov on 5/29/18.
//  Copyright © 2018 Alex Usachov. All rights reserved.
//

#include <iostream>
#include <vector>

extern "C"
{
    #include "lua/lua.h"
    #include "lua/lauxlib.h"
    #include "lua/lualib.h"
}
//------------------------------------------------------------------------
void
TraceVec(const std::vector<long>& vec, const std::string& title = "")
{
    if ( !title.empty() )
    {
        std::cout << title << std::endl;
    }
    std::copy(vec.begin(), vec.end(), std::ostream_iterator<long>(std::cout,","));
    
    std::cout << std::endl;
}
//------------------------------------------------------------------------
int
main()
{
    std::vector<long> VecInput {5,3,12,14,2,7,3,9,6,1};
    std::vector<long> VecSorted {};
    
    TraceVec(VecInput, "Vector on C is:");
    
    int status, result, i;
    lua_State *L;
    
    L = luaL_newstate();
    
//  Load libraries
    luaL_openlibs(L);
    
//  Load lua script to execute
    status = luaL_loadfile(L, "luascript/main.lua");
    if (status)
    {
        fprintf(stderr, "Couldn't load file: %s\n", lua_tostring(L, -1));
        exit(1);
    }
    
    //Create a table for our array to pass it from C++
    lua_newtable(L);
    
    //Pass array data
    for (i = 0; i < VecInput.size(); i++)
    {
        lua_pushnumber(L, i+1);   // Table index usually starts from 1 in lua
        lua_pushnumber(L, VecInput[i]); // Value of element
        lua_rawset(L, -3);      // Store pair in table
    }
    
    // Set name for created table in lua to have access
    lua_setglobal(L, "ArrFromC");
    
    result = lua_pcall(L, 0, LUA_MULTRET, 0);
    if (result)
    {
        fprintf(stderr, "Failed to run script: %s\n", lua_tostring(L, -1));
        exit(1);
    }
    
    luaL_checktype(L, -1, LUA_TTABLE);
    size_t LenArr = luaL_len(L, 1);
    for (size_t i = 1; i <= LenArr; i++)
    {
        lua_rawgeti(L, 1, i);
        long v = lua_tointeger(L,-1);
        VecSorted.push_back(v);
        lua_pop(L,1);
    }
    
    lua_close(L);
    
    TraceVec(VecSorted, "Vector on C after lua script is:");
    
    return 0;
}
//------------------------------------------------------------------------
