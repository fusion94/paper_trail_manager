import {CSSProperties} from "react"

export const availableColumns = [
  "version_id",
  "item_type",
  "item_id",
  "event",
  "time",
  "whodunnit",
  "changes",
  "actions",
] as const

export type Column = typeof availableColumns[number]
export type ColumnPicks = Record<Column, boolean>
export type ViewedList = Version["id"][]

export type Config = {
  columns: ColumnPicks
  setColumns: React.Dispatch<React.SetStateAction<ColumnPicks>>
  viewed: ViewedList
  setViewed: React.Dispatch<React.SetStateAction<ViewedList>>
}

export interface Version {
  id: number
  item_type: string
  item_id: string
  whodunnit?: string
  event: string
  created_at: string
  changeset: Record<string, [unknown, unknown]>
  object: Record<string, unknown>
  item_url?: string
  user_url?: string
}

export const stickyStyle = {
  position: "sticky",
  background: "#ffffffdd",
  zIndex: 10,
} as CSSProperties
