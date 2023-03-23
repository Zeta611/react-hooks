// This is an OK code, but does nothing.
@react.component
let make = () => {
  let (a, setA) = React.Uncurried.useState(() => 1)
  React.useEffect(() => {
    setA(.a => a)
    None
  })
  a->Int.toString->React.string
}

// This leads to an infinite render. ESLint is blind!
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   React.useEffect(() => {
//     setA(.a => a + 1)
//     None
//   })
//   a->Int.toString->React.string
// }

// This "runs" OK, but "a" is useless and "setA" is used. ESLint catches it.
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   React.useEffect1(() => {
//     setA(.a => a)
//     None
//   }, [a])
//   a->Int.toString->React.string
// }

// This is a fine code.
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   React.useEffect1(() => {
//     setA(.a => a + 1)
//     None
//   }, [setA])
//   a->Int.toString->React.string
// }

// This is a really bad code. ESLint is happy with it.
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   setA(._ => 2)
//   a->Int.toString->React.string
// }

// This violates "The Rules of Hooks" and ESLint catches it.
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   if a > 0 {
//     React.useEffect1(() => {
//       setA(.a => a + 1)
//       None
//     }, [setA])
//   }
//   a->Int.toString->React.string
// }

// ESLint catches this violation of "The Rules of Hooks"
// let foo = () => {
//   let (a, setA) = React.Uncurried.useState(() => 1)
//   setA(._ => a)
// }

// Fine code
// @react.component
// let make = () => {
//   let a = ref(0)
//   a := a.contents + 1
//   a.contents->Int.toString->React.string
// }

// Fine code
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => 0)
//   <button onClick={_ => setA(.a => a + 1)}> {a->Int.toString->React.string} </button>
// }

// Wrong! Can we even handle this?
// @react.component
// let make = () => {
//   let a = ref(0)
//   <button onClick={_ => {a := a.contents + 1}}> {a.contents->Int.toString->React.string} </button>
// }

// Wrong again! Can we even handle this?
// let a = ref(0)
// @react.component
// let make = () => {
//   <button onClick={_ => {a := a.contents + 1}}> {a.contents->Int.toString->React.string} </button>
// }

// Wrong yet again!
// let a = ref(0)
// module Child = {
//   @react.component
//   let make = () => {
//     a := a.contents + 1
//     <h1> {a.contents->Int.toString->React.string} </h1>
//   }
// }
// @react.component
// let make = () => {
//   <>
//     <Child />
//     <Child />
//     <Child />
//   </>
// }

// This leads to an infinite loop
// @react.component
// let make = () => {
//   let (a, setA) = React.Uncurried.useState(() => {"value": 1})
//   React.useEffect(() => {
//     setA(._ => {"value": 1})
//     None
//   })
//   a["value"]->Int.toString->React.string
// }

// Redundant state
// @react.component
// let make = () => {
//   let (a, _setA) = React.Uncurried.useState(() => 1)
//   let (b, _setB) = React.Uncurried.useState(() => 2)

//   let (c, setC) = React.Uncurried.useState(() => 0)
//   React.useEffect2(() => {
//     setC(._ => a + b)
//     None
//   }, (a, b))
//   c->Int.toString->React.string
// }
