---james edit 20141127  get = > post,get 
local request_method = ngx.var.request_method
local args = nil

if "GET" == request_method then
    args = ngx.req.get_uri_args()
elseif "POST" == request_method then
    ngx.req.read_body()
    args = ngx.req.get_post_args()
end


local redis = require "resty.redis"
local red = redis:new()
local ok, err = red:connect("192.168.50.112", 6379)
if not ok then
	ngx.say("failed to connect: ", err)
	return
end


local res, err = red:auth("redispasswd")
if not res then
      ngx.say("false")
      return
end




--ngx.say(args.arg_fun);
--ngx.say(args.fun)  
--ngx.var.arg_

local fun = args.fun
if fun == "hgetall" then 
	local res, err = red:hgetall(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res then 
		for i, out_res in ipairs(res) do
			ngx.say(out_res) 
		end 
	else
		ngx.say("false") 
	end
	return
elseif fun == "get" then 
	local res, err = red:get(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res == ngx.null then
		ngx.say("")
		return
	end
	if res then 
		ngx.say( res ) 
	else
		ngx.say("false") 
	end				
	return
 elseif fun == "hget" then 
	local res, err = red:hget(args.key, args.field)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res == ngx.null then
		ngx.say("")
		return
	end
	if res then 
		ngx.say( res ) 
	else
		ngx.say("false") 
	end				
	return
 elseif fun == "hdel" then
        local res, err = red:hdel(args.key, args.field)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return
elseif fun == "smembers" then 
	local res, err = red:smembers(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res then 
		for i, out_res in ipairs(res) do
			ngx.say(out_res) 
		end 
	else
		ngx.say("false") 
	end
	return
elseif fun == "sdiff" then 
	local res, err = red:sdiff(args.key1,args.key2)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res then 
		for i, out_res in ipairs(res) do
			ngx.say(out_res) 
		end 
	else
		ngx.say("false") 
	end
	return
elseif fun == "sadd" then 
	local res, err = red:sadd(args.key, args.value)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res)
	return
elseif fun == "set" then 
	local res, err = red:set(args.key, args.value)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "hset" then 
	local res, err = red:hset(args.key, args.field, args.value)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "del" then 
	local res, err = red:del(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "zcard" then 
	local res, err = red:zcard(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
 elseif fun == "zadd" then 
	local res, err = red:zadd(args.key,args.score,args.value)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "zrangebyscore" then 
	local res, err = red:zrangebyscore(args.key,args.min,args.max)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res then 
		for i, out_res in ipairs(res) do
			ngx.say(out_res) 
		end 
	else
		ngx.say("false") 
	end
	return

elseif fun == "zscore" then
        local res, err = red:zscore(args.key,args.value)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return

elseif fun == "zrem" then
        local res, err = red:zrem(args.key,args.value)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return

elseif fun == "zremrangebyscore" then
        local res, err = red:zremrangebyscore(args.key,args.min,args.max)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return

elseif fun == "zrange" then
        local res, err = red:zrange(args.key,args.start,args.stop,args.withscores)

        if not ok then
                ngx.say("false")
                return
        end
        if res then
                for i, out_res in ipairs(res) do
                        ngx.say(out_res)
                end
        else
                ngx.say("false")
        end
        return

elseif fun == "zrevrange" then
        local res, err = red:zrevrange(args.key,args.start,args.stop,args.withscores)
        if not ok then
                ngx.say("false")
                return 
        end
        if res then
                for i, out_res in ipairs(res) do
                        ngx.say(out_res)
                end
        else
                ngx.say("false")
        end
        return

elseif fun == "rpush" then 
	local res, err = red:rpush(args.key,args.value)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "llen" then 
	local res, err = red:llen(args.key)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	ngx.say(res) 
	return
elseif fun == "lrange" then 
	local res, err = red:lrange(args.key,args.start,args.stop)
	if not ok then  
		ngx.say("false")  
		return  
	end 
	if res then 
		for i, out_res in ipairs(res) do
			ngx.say(out_res) 
		end 
	else
		ngx.say("false") 
	end
	return
elseif fun == "incr" then
        local res, err = red:incr(args.key)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return
elseif fun == "expire" then
        local res, err = red:expire(args.key, args.sec)
        if not ok then
                ngx.say("false")
                return
        end
        ngx.say(res)
        return


else 
	ngx.say("false")
	return
end

