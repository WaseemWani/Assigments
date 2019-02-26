
 (function() {
  'use strict';
	var Employee=[{name:"arav",age:20,salary:6000,dob:"6 may 1998"},
			 {name:"abhinav",age:23,salary:400,dob:"16 feb 1998"},
			 {name:"anubhav",age:25,salary:3000,dob:"21 june 1999"},
			 {name:"akash",age:26,salary:2000,dob:"26 may 1988"},
			{name: "anbhey kumar",age:43, salary: 500, dob:"26 may 1988"}]
			 
			 //writing the data on screen
			 
	document.write("part1")		 
	for(var key in Employee)
		document.write("Name: "+Employee[key].name+" Age: "+Employee[key].age+" Salary: "+Employee[key].salary+" Date of Birth: "+Employee[key].dob+"<br><br>");
	document.write("<hr>");
	document.write("salary more then 5000 <br>");
	
	// fetching the employees with salary greater than 5000
	
	for(var key in Employee)
	{if((Employee[key].salary)>5000)
		document.write(Employee[key].name);
	}
	document.write("");
	
	// grouping emloyees by age
	
	for(var key in Employee)
	{if((Employee[key].age)>35)
		document.write(Employee[key].name+" is older  <br>");
	}
	
	document.write("<hr>");
	for(var key in Employee)
	{if((Employee[key].age)<=35)
		document.write(Employee[key].name+" is younger <br>");
	}
  
  // fetching the  employess with salary less than 1000 and age greater than 20
  
  document.write("<hr>");
	for(var key in Employee)
	{if((Employee[key].age)>20 && (Employee[key].salary)<1000 )
  {document.write(Employee[key].name+" is more than 20 years of age and has  salary less then 1000<br>");
    Employee[key].salary=Employee[key].salary*4;
   document.write("after increment salary will be :"+Employee[key].salary);
  }
	}
}
 ()
); 