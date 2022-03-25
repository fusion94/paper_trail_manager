import React, {useState} from "react"
import ReactModal from "react-modal"

export const Modal = ({
  children,
  trigger,
}: {
  children: React.ReactNode
  trigger: string
}) => {
  const [open, setOpen] = useState(false)

  return (
    <>
      <span style={{cursor: "pointer"}} onClick={() => setOpen(!open)}>
        {trigger}
      </span>
      <ReactModal
        ariaHideApp={false}
        isOpen={open}
        onRequestClose={() => setOpen(false)}
        style={{overlay: {zIndex: 20}}}
      >
        <span
          onClick={() => setOpen(false)}
          style={{cursor: "pointer", float: "right"}}
        >
          ╳
        </span>
        {children}
      </ReactModal>
    </>
  )
}
