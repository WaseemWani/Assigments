        //this is the java script file for - we are creatinga an object and copeing it to another,logging the resukt to console  

	  //creating an object car
	  
	  var car = { Color:"blue", Model:"2019", Name:"BMW"}
	  
	  //creating a copy of the object- obect.assign assigns(obj1) object obj1 to another object

	  var copyCar = Object.assign(car);
	  
	  //shwoing the contents of the object car 
	    
		document.write("<p> This is the object created: "+JSON.stringify(car)+"</p>");
	
          //shwoing the contents of the object car 
 
		document.write("<p> Object copied here: "+JSON.stringify(copyCar)+"</p>");
		
		//showing the result on console
		 
	        console.log(JSON.stringify(copyCar));
