`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;

  `uvm_component_utils(driver)
  
  int base_start_value;
  string name;

  function new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //----------------------------CHECKING IN DB---------------------------------
    if(uvm_config_db#(int)::exists(this,"","sample"))
    begin:BEGIN_IF_EXIST_1
    
    //----------------------------GETTING FROM DB--------------------------------
      if(uvm_config_db#(int)::get(this,"","sample",base_start_value))
      begin:BEGIN_IF_GET_1
        `uvm_info(get_type_name,"getting value from sample",UVM_LOW)
        `uvm_info(get_type_name,$sformatf("base_start_value = %0d",base_start_value),UVM_LOW)
      end:BEGIN_IF_GET_1
      else
      begin:BEGIN_ELSE_GET_1
        `uvm_error(get_type_name,"The base start value was not getting from sample")
      end:BEGIN_ELSE_GET_1
    //----------------------------GETTING FROM DB--------------------------------
    
    end:BEGIN_IF_EXIST_1
    else
    begin:BEGIN_ELSE_EXIST_1
      
    //----------------------------GETTING FROM DB--------------------------------
      if(uvm_config_db#(int)::get(this,"","base_value",base_start_value))
      begin:BEGIN_IF_GET_2
        `uvm_info(get_type_name,"getting value from base value",UVM_LOW)
        `uvm_info(get_type_name,$sformatf("base_start_value = %0d",base_start_value),UVM_LOW)
      end:BEGIN_IF_GET_2
      else
      begin:BEGIN_ELSE_GET_2
        `uvm_error(get_type_name,"The base start value was not getting from base value")
      end:BEGIN_ELSE_GET_2
    //----------------------------GETTING FROM DB--------------------------------
    
    end:BEGIN_ELSE_EXIST_1
    //----------------------------CHECKING IN DB---------------------------------
    
    //----------------------------GETTING FROM DB--------------------------------
    uvm_config_db#(string)::get(this,"","my_name",name);
    `uvm_info(get_type_name,$sformatf("[dri] name = %0s",name),UVM_LOW)
    //----------------------------GETTING FROM DB--------------------------------

  endfunction:build_phase

endclass:driver

class environment extends uvm_env;

  `uvm_component_utils(environment)
  
  driver dri;
  string avengers,name;

  function new(string name = "environment",uvm_component parent = null);
    super.new(name,parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    dri = driver::type_id::create("dri",this);
    
    //----------------------------CHECKING IN DB---------------------------------
    if(uvm_config_db#(int)::exists(null,"uvm_test_top","base_value"))
    begin:BEGIN_IF
    //----------------------------SETTING TO DB----------------------------------
      uvm_config_db#(int)::set(this,"dri","sample",30);
      `uvm_info(get_type_name,"sample value set successfully",UVM_LOW)
    //----------------------------SETTING TO DB----------------------------------
    end:BEGIN_IF
    else
    begin:BEGIN_ELSE
    //----------------------------SETTING TO DB----------------------------------
      uvm_config_db#(int)::set(this,"dri","base_value",20);
      `uvm_info(get_type_name,"base value set successfully",UVM_LOW)
    //----------------------------SETTING TO DB----------------------------------
    end:BEGIN_ELSE
    //----------------------------CHECKING IN DB---------------------------------

    //----------------------------SETTING TO DB----------------------------------
    uvm_config_db#(string)::set(this,"dri","my_name","kumar");
    `uvm_info(get_type_name,"my name set successfully",UVM_LOW)
    //----------------------------SETTING TO DB----------------------------------
 
    //----------------------------GETTING FROM DB--------------------------------
    if(uvm_config_db#(string)::get(this,"","captain",avengers))
      `uvm_info(get_type_name,$sformatf("avengers = %0s",avengers),UVM_LOW)
    else
      `uvm_error(get_type_name,"The captain we are not getting into test")
    //----------------------------GETTING FROM DB--------------------------------
  
  endfunction:build_phase

endclass:environment

class test extends uvm_test;

  `uvm_component_utils(test)

  environment env;
  int a;

  function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
        
    //----------------------------SETTING TO DB----------------------------------
    uvm_config_db#(string)::set(this,"env","captain","America");
    uvm_config_db#(string)::set(this,"*","my_name","vinay");
    //----------------------------SETTING TO DB----------------------------------
    
    //----------------------------GETTING FROM DB--------------------------------
    if(uvm_config_db#(int)::get(this,"","base_value",a))
      `uvm_info(get_type_name,$sformatf("a = %0d",a),UVM_LOW)
    else
      `uvm_error(get_type_name,"The base value we are not getting from test")
    //----------------------------GETTING FROM DB--------------------------------
  endfunction:build_phase

endclass:test

module top;

  initial begin:BEGIN_I
    //----------------------------SETTING TO DB----------------------------------
    uvm_config_db#(int)::set(null,"uvm_test_top","base_value",10);
    //----------------------------SETTING TO DB----------------------------------
    run_test("test");
  end:BEGIN_I

endmodule:top
