/* 
	-- Proove Narcotic Risk Profile Doughnut Graph -- 
*/

window.onload = function(){
	var canvas = document.getElementById('risk-index-value');
	var ctx = canvas.getContext('2d');
	var degrees = 0;
	var color = '#f0532d';
	var bgcolor = '#d3d3d3';
	var subbgcolor = '#e9e9e9';
	var text;
	var risk;
	
	// Dimensions 
	
	var W = canvas.width;
	var H = canvas.height;
	
	ctx.clearRect(0,0,W,H);
	
	// Background & Gauge 360deg arc
	
	function init(){
		
		var currentvalue = text;
		var currentcolor = color;
		
		ctx.clearRect(0,0,W,H);
		
		// Sub Background
		
		ctx.beginPath();
		ctx.strokeStyle = subbgcolor;
		ctx.lineWidth = 26;
		ctx.arc(W/3.7,H/1.82,55,0,Math.PI*2,false);
		ctx.stroke();
		
		// Background
		
		ctx.beginPath();
		ctx.strokeStyle = bgcolor;
		ctx.lineWidth = 12;
		ctx.arc(W/3.7,H/1.82,55,0,Math.PI*2,false);
		ctx.stroke();
		
		// Gauge
		
		var radius = degrees * Math.PI / 180;
		ctx.beginPath();
		ctx.strokeStyle = colorValues();
		ctx.lineWidth = 12;
		ctx.arc(W/3.7, H/1.82,55,0 - 90 * Math.PI/180 ,radius - 90 * Math.PI/180,false);
		ctx.stroke();
		
		// Value
		
		ctx.fillStyle = "#000";
		ctx.font ="700 34.06pt 'PT Sans'";
		text = Math.floor(degrees/360*36);
		text_width = ctx.measureText(text).width;
		ctx.fillText(text,W/3.7- text_width/2,H/2 + 20);
		
		// Sub Value
		
		ctx.fillStyle = "#707070";
		ctx.font ="700 9.93pt 'PT Sans'";
		risk = riskValues();
		risk_width = ctx.measureText(risk).width;
		ctx.fillText(risk,W/3.7- risk_width/2,H/1 - 37);
		
		// -------------------- FIX THIS FUNCTION --------------------
		
		// Sets HIGH, MEDIUM, and LOW based on value
		
		function riskValues(){
			if(parseInt(currentvalue) <= 12){
				return "LOW";
			} else if (parseInt(currentvalue) <= 24){
				return "MEDIUM";
			} else {
				return "HIGH";
			}
		}
		
		// Sets color based on value
		
		function colorValues(){
			if(parseInt(currentvalue) <= 12){
				return "#66bf99";
			} else if (parseInt(currentvalue) <= 24){
				return "#FBAD17";
			} else {
				return "#f0532d";
			}
		}
		
		//------------------------------------------------------------
	}
	
	function draw(){
		new_degrees = Math.round(Math.random()*360);
		var radius_difference = new_degrees - degrees;
		animation_loop = setInterval(animate_to, 1000/radius_difference);
		
	}
	
	function animate_to(){
		if(degrees < new_degrees){
			degrees++;
		} else {
			degrees--;
		}
		
		if(degrees === new_degrees){
			clearInterval(animation_loop);
		}
		
		init();
	}
	
	draw();
	// draw_loop = setInterval(draw, 2000);
}