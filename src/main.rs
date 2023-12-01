use anyhow::Result;
use wasmtime::*;

const INPUT : &[u8] = include_bytes!("data/day01.txt");
fn main() -> Result<(),Error> {
    
    
       let mut config = Config::default();
       let engine = Engine::new(config.debug_info(true))?;
       let module = Module::from_file(&engine, "wat/day01.wasm")?;
       let mut store = Store::new(&engine, ());
   
       let instance = Instance::new(&mut store, &module, &[])?;
   
       let memory = instance
           .get_memory(&mut store, "memory").expect("no `memory` export");
       let target = memory.data_mut(&mut store);
       let (target,_) = target.split_at_mut(INPUT.len());
       target.copy_from_slice(INPUT);
   
       let part_one = instance.get_typed_func::<i32, i32>(&mut store, "part_one")?;
       let result = part_one.call(&mut store, INPUT.len() as i32)?;
   
       println!("part one {result}");
    
       let part_one = instance.get_typed_func::<i32, i32>(&mut store, "part_one")?;
       let result = part_one.call(&mut store, INPUT.len() as i32)?;
   
       println!("part two {result}");
    
       Ok(())
}
