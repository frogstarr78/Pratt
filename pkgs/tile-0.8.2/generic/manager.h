/* manager.h,v 1.11 2007/11/25 17:17:09 jenglish Exp
 *
 * Copyright (c) 2005, Joe English.  Freely redistributable.
 *
 * Geometry manager utilities.
 */

#ifndef _TTKMANAGER
#define _TTKMANAGER

typedef struct TtkManager_ Ttk_Manager;

/*
 * Geometry manager specification record:
 *
 * RequestedSize computes the requested size of the master window.
 *
 * PlaceSlaves sets the position and size of all managed slaves
 * by calling Ttk_PlaceSlave().
 *
 * SlaveRemoved() is called immediately before a slave is removed.
 * NB: the associated slave window may have been destroyed when this
 * routine is called.
 * 
 * SlaveRequest() is called when a slave requests a size change.
 * It should return 1 if the request should propagate, 0 otherwise.
 */
typedef struct {			/* Manager hooks */
    Tk_GeomMgr tkGeomMgr;		/* "real" Tk Geometry Manager */

    int  (*RequestedSize)(void *managerData, int *widthPtr, int *heightPtr);
    void (*PlaceSlaves)(void *managerData);
    int  (*SlaveRequest)(void *managerData, int slaveIndex, int w, int h);
    void (*SlaveRemoved)(void *managerData, int slaveIndex);
} Ttk_ManagerSpec;

/*
 * Default implementations for Tk_GeomMgr hooks:
 */
extern void Ttk_GeometryRequestProc(ClientData, Tk_Window slave);
extern void Ttk_LostSlaveProc(ClientData, Tk_Window slave);

/*
 * Public API:
 */
extern Ttk_Manager *Ttk_CreateManager(
	Ttk_ManagerSpec *, void *managerData, Tk_Window masterWindow);
extern void Ttk_DeleteManager(Ttk_Manager *);

extern void Ttk_InsertSlave(
    Ttk_Manager *, int position, Tk_Window, void *slaveData);

extern void Ttk_ForgetSlave(Ttk_Manager *, int slaveIndex);

extern void Ttk_ReorderSlave(Ttk_Manager *, int fromIndex, int toIndex);
    /* Rearrange slave positions */

extern void Ttk_PlaceSlave(
    Ttk_Manager *, int slaveIndex, int x, int y, int width, int height);
    /* Position and map the slave */

extern void Ttk_UnmapSlave(Ttk_Manager *, int slaveIndex);
    /* Unmap the slave */

extern void Ttk_ManagerSizeChanged(Ttk_Manager *);
extern void Ttk_ManagerLayoutChanged(Ttk_Manager *);
    /* Notify manager that size (resp. layout) needs to be recomputed */

/* Utilities:
 */
extern int Ttk_SlaveIndex(Ttk_Manager *, Tk_Window);
    /* Returns: index in slave array of specified window, -1 if not found */

extern int Ttk_GetSlaveIndexFromObj(
    Tcl_Interp *, Ttk_Manager *, Tcl_Obj *, int *indexPtr);

/* Accessor functions:
 */
extern int Ttk_NumberSlaves(Ttk_Manager *);
    /* Returns: number of managed slaves */

extern void *Ttk_SlaveData(Ttk_Manager *, int slaveIndex);
    /* Returns: client data associated with slave */

extern Tk_Window Ttk_SlaveWindow(Ttk_Manager *, int slaveIndex);
    /* Returns: slave window */

extern int Ttk_Maintainable(Tcl_Interp *, Tk_Window slave, Tk_Window master);
    /* Returns: 1 if master can manage slave; 0 otherwise leaving error msg */

#endif /* _TTKMANAGER */
