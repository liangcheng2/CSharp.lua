-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System
local CSharpLuaLuaAst
System.usingDeclare(function (global) 
  CSharpLuaLuaAst = CSharpLua.LuaAst
end)
System.namespace("CSharpLua.LuaAst", function (namespace) 
  namespace.class("LuaMemberAccessExpressionSyntax", function (namespace) 
    local getIsObjectColon, Render, __ctor__
    __ctor__ = function (this, expression, name, isObjectColon) 
      this.__base__.__ctor__(this)
      if expression == nil then
        System.throw(System.ArgumentNullException("expression" --[[nameof(expression)]]))
      end
      if name == nil then
        System.throw(System.ArgumentNullException("name" --[[nameof(name)]]))
      end
      this.Expression = expression
      this.Name = name
      this.OperatorToken = isObjectColon and ":" --[[Tokens.ObjectColon]] or "." --[[Tokens.Dot]]
    end
    getIsObjectColon = function (this) 
      return this.OperatorToken == ":" --[[Tokens.ObjectColon]]
    end
    Render = function (this, renderer) 
      renderer:Render3(this)
    end
    return {
      __inherits__ = function (global) 
        return {
          global.CSharpLua.LuaAst.LuaExpressionSyntax
        }
      end, 
      getIsObjectColon = getIsObjectColon, 
      Render = Render, 
      __ctor__ = __ctor__
    }
  end)
  namespace.class("LuaPropertyAdapterExpressionSyntax", function (namespace) 
    local Update, setIsGetOrAdd, getIsGetOrAdd, getIsProperty, getIsObjectColon, GetClone, GetCloneOfGet, Render, 
    __init__, __ctor1__, __ctor2__
    __init__ = function (this) 
      this.ArgumentList = CSharpLuaLuaAst.LuaArgumentListSyntax()
    end
    __ctor1__ = function (this, name) 
      __init__(this)
      this.__base__.__ctor__(this)
      this.Name = name
    end
    __ctor2__ = function (this, expression, name, isObjectColon) 
      __init__(this)
      this.__base__.__ctor__(this)
      Update(this, expression, isObjectColon)
      this.Name = name
    end
    Update = function (this, expression, isObjectColon) 
      assert(this.Expression == nil)
      this.Expression = expression
      this.OperatorToken = isObjectColon and ":" --[[Tokens.ObjectColon]] or "." --[[Tokens.Dot]]
    end
    setIsGetOrAdd = function (this, value) 
      this.Name.IsGetOrAdd = value
    end
    getIsGetOrAdd = function (this) 
      return this.Name.IsGetOrAdd
    end
    getIsProperty = function (this) 
      return this.Name.IsProperty
    end
    getIsObjectColon = function (this) 
      return this.OperatorToken == ":" --[[Tokens.ObjectColon]]
    end
    GetClone = function (this) 
      local clone = CSharpLuaLuaAst.LuaPropertyAdapterExpressionSyntax:new(1, this.Name:GetClone())
      clone.Expression = this.Expression
      clone.OperatorToken = this.OperatorToken
      clone.ArgumentList.Arguments:AddRange(this.ArgumentList.Arguments)
      return clone
    end
    GetCloneOfGet = function (this) 
      local clone = GetClone(this)
      setIsGetOrAdd(clone, true)
      setIsGetOrAdd(this, false)
      return clone
    end
    Render = function (this, renderer) 
      renderer:Render58(this)
    end
    return {
      __inherits__ = function (global) 
        return {
          global.CSharpLua.LuaAst.LuaExpressionSyntax
        }
      end, 
      Update = Update, 
      setIsGetOrAdd = setIsGetOrAdd, 
      getIsGetOrAdd = getIsGetOrAdd, 
      getIsProperty = getIsProperty, 
      getIsObjectColon = getIsObjectColon, 
      GetClone = GetClone, 
      GetCloneOfGet = GetCloneOfGet, 
      Render = Render, 
      __ctor__ = {
        __ctor1__, 
        __ctor2__
      }
    }
  end)
end)
