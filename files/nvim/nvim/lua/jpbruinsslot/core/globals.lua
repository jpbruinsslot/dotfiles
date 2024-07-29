-- example: :lua P(vim.api)
P = function(v)
	print(vim.inspect(v))
	return v
end

R = function(name)
	RELOAD(name)
	return require(name)
end
