CoD.T5HintStringIcon = InheritFrom( LUI.UIElement )
CoD.T5HintStringIcon.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end
	self:setUseStencil( false )
	self:setClass( CoD.T5HintStringIcon )
	self.id = "T5HintStringIcon"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 108 )
	self:setTopBottom( true, false, 0, 54 )
	
	local c1x1 = LUI.UIImage.new()
	c1x1:setLeftRight( true, true, 0, -54 )
	c1x1:setTopBottom( true, true, 0, 0 )
	c1x1:setAlpha( 0 )
	c1x1:subscribeToGlobalModel( controller, "HUDItems", "cursorHintImage", function ( modelRef )
		local cursorHintImage = Engine.GetModelValue( modelRef )
		if cursorHintImage then
			c1x1:setImage( RegisterImage( cursorHintImage ) )
		end
	end )
	self:addElement( c1x1 )
	self.c1x1 = c1x1
	
	local x1x4 = LUI.UIImage.new()
	x1x4:setLeftRight( true, true, 0, 0 )
	x1x4:setTopBottom( true, true, 13.5, -13.5 )
	x1x4:subscribeToGlobalModel( controller, "HUDItems", "cursorHintImage", function ( modelRef )
		local cursorHintImage = Engine.GetModelValue( modelRef )
		if cursorHintImage then
			x1x4:setImage( RegisterImage( cursorHintImage ) )
		end
	end )
	self:addElement( x1x4 )
	self.x1x4 = x1x4
	
	local c1x2 = LUI.UIImage.new()
	c1x2:setLeftRight( true, true, 0, 0 )
	c1x2:setTopBottom( true, true, 0, 0 )
	c1x2:setAlpha( 0 )
	c1x2:subscribeToGlobalModel( controller, "HUDItems", "cursorHintImage", function ( modelRef )
		local cursorHintImage = Engine.GetModelValue( modelRef )
		if cursorHintImage then
			c1x2:setImage( RegisterImage( cursorHintImage ) )
		end
	end )
	self:addElement( c1x2 )
	self.c1x2 = c1x2

	local c1x0 = LUI.UIImage.new()
	c1x0:setLeftRight( true, true, 0, 0 )
	c1x0:setTopBottom( true, true, 0, 0 )
	c1x0:setAlpha( 0 )
	c1x0:subscribeToGlobalModel( controller, "HUDItems", "cursorHintImage", function ( modelRef )
		local cursorHintImage = Engine.GetModelValue( modelRef )
		if cursorHintImage then
			c1x0:setImage( RegisterImage( cursorHintImage ) )
		end
	end )
	self:addElement( c1x0 )
	self.c1x0 = c1x0
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )
				c1x0:completeAnimation()
				self.c1x0:setAlpha( 0 )
				self.clipFinished( c1x0, {} )
				c1x1:completeAnimation()
				self.c1x1:setAlpha( 0 )
				self.clipFinished( c1x1, {} )
				x1x4:completeAnimation()
				self.x1x4:setAlpha( 0 )
				self.clipFinished( x1x4, {} )
				c1x2:completeAnimation()
				self.c1x2:setAlpha( 0 )
				self.clipFinished( c1x2, {} )
			end
		},
		Active_1x0 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )
				c1x0:completeAnimation()
				self.c1x0:setAlpha( 1 )
				self.clipFinished( c1x0, {} )
				c1x1:completeAnimation()
				self.c1x1:setAlpha( 0 )
				self.clipFinished( c1x1, {} )
				x1x4:completeAnimation()
				self.x1x4:setAlpha( 0 )
				self.clipFinished( x1x4, {} )
				c1x2:completeAnimation()
				self.c1x2:setAlpha( 0 )
				self.clipFinished( c1x2, {} )
			end
		},
		Active_1x1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )
				c1x0:completeAnimation()
				self.c1x0:setAlpha( 0 )
				self.clipFinished( c1x0, {} )
				c1x1:completeAnimation()
				self.c1x1:setAlpha( 1 )
				self.clipFinished( c1x1, {} )
				x1x4:completeAnimation()
				self.x1x4:setAlpha( 0 )
				self.clipFinished( x1x4, {} )
				c1x2:completeAnimation()
				self.c1x2:setAlpha( 0 )
				self.clipFinished( c1x2, {} )
			end
		},
		Active_2x1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )
				c1x0:completeAnimation()
				self.c1x0:setAlpha( 0 )
				self.clipFinished( c1x0, {} )
				c1x1:completeAnimation()
				self.c1x1:setAlpha( 0 )
				self.clipFinished( c1x1, {} )
				x1x4:completeAnimation()
				self.x1x4:setAlpha( 0 )
				self.clipFinished( x1x4, {} )
				c1x2:completeAnimation()
				self.c1x2:setAlpha( 1 )
				self.clipFinished( c1x2, {} )
			end
		},
		Active_4x1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )
				c1x0:completeAnimation()
				self.c1x0:setAlpha( 0 )
				self.clipFinished( c1x0, {} )
				c1x1:completeAnimation()
				self.c1x1:setAlpha( 0 )
				self.clipFinished( c1x1, {} )
				x1x4:completeAnimation()
				self.x1x4:setAlpha( 1 )
				self.clipFinished( x1x4, {} )
				c1x2:completeAnimation()
				self.c1x2:setAlpha( 0 )
				self.clipFinished( c1x2, {} )
			end
		},
		Out = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		}
	}
	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.c1x1:close()
		element.x1x4:close()
		element.c1x2:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end

