---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by onelei.
--- DateTime: 2020/8/2 13:19
---

---@class LuaBehavior

LuaBehavior = {}

local __Target_Pool

function LuaBehavior.Init()
    __Target_Pool = {}
end

function LuaBehavior.AddEnable(go,func_enable)
    LuaBehavior.Get(go)
    __Target_Pool[go].func_enable = func_enable
end

function LuaBehavior.AddUpdate(go,func_update)
    LuaBehavior.Get(go)
    __Target_Pool[go].func_update = func_update
end

function LuaBehavior.AddLateUpdate(go,func_lateupdate)
    LuaBehavior.Get(go)
    __Target_Pool[go].func_lateupdate = func_lateupdate
end

function LuaBehavior.Remove(go)
    if go and __Target_Pool[go] and __Target_Pool[go].component then
        go:RemoveComponent(__Target_Pool[go].component)
        __Target_Pool[go].component = nil
        __Target_Pool[go] = nil
    end
end

function LuaBehavior.OnEnable(go)
    if __Target_Pool[go] and __Target_Pool[go].func_enable then
        __Target_Pool[go].func_enable()
    end
end

function LuaBehavior.Update(go)
    if __Target_Pool[go] and __Target_Pool[go].func_update then
        __Target_Pool[go].func_update()
    end
end

function LuaBehavior.LateUpdate(go)
    if __Target_Pool[go] and __Target_Pool[go].func_lateupdate then
        __Target_Pool[go].func_lateupdate()
    end
end

function LuaBehavior.Get(go)
    if not go then
        Debug.LogError("go is null")
        return
    end

    if not __Target_Pool[go] then
        __Target_Pool[go] = {}
    end

    if not __Target_Pool[go].component then
        local component = go:GetOrAddComponent(typeof(CS.Lemon.LuaBehaviour))
        __Target_Pool[go].component = component
    end
end

function LuaBehavior.Test(value)
    local gameObject = CS.UnityEngine.GameObject("LuaBehavior")
    LuaBehavior.AddUpdate(gameObject,function ()
        TimeMgr.Update()
        StepUtility.Update()
    end)

    TimeMgr.Add(3,function ()
        Debug.Log("delay 50")
        StepUtility.Append(StepUtility.EAction.TEST1,"Hello Test1")
        StepUtility.Append(StepUtility.EAction.TEST2,"Hello Test2")
    end)

end

LuaBehavior.Init()

return LuaBehavior