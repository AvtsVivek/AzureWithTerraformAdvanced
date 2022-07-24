# Auto Scaling of Azure Virtual Machines Scale Set

## ntro

- In this tute, we change the scaling to Auto. We will build on the previous tutorial.

## Autosaling default profile

- Defaults to round the clock schedule

- Mandatory Profile

- Will not execute if Recurrence or Fixed Profile exists

## Autosaling Recurrence profile

- Recur on those days with start time specified

- Week Day  and Weekend profiles

- Business Hour and Non-Business Hour profile

## Autosaling Fixed profile

- Executes on that specific day

- Fixed profile takes priority 1 for execution on that day if exists

## Priority

- Priority Execution Order for Autoscaling Profiles is as follows

    - Autoscaling Fixed Profile
    - Autoscaling Recurrence Profile
    - Autoscaling Default Profile

- The layout

![The layout](./Images/Layout-Auto.jpg)

- The following is the Manual scale config

![Manual Scale config](./Images/Portail-Ui-Manual-Scale.jpg)

- Changing that to Auto scale config

![Auto Scale config](./Images/Portail-Ui-Auto-Scale-config.jpg)

- Add Rule

![Add Rule](./Images/Scale-in-rule.jpg)

- Out and in rules

![Out and in](./Images/Scale-Out-In.jpg)

- Available Memory bytes

![Other Sources](./Images/AvailableMemoryBytesRule.jpg)

- Add Rule SYN Count 

![Other Sources](./Images/LbSynCountRule1.jpg)

- Add Rule SYN Count

![Other Sources](./Images/LbSynCountRule2.jpg)

- Add Rule

![Other Sources](./Images/Other-Sources-in.jpg)

- Out and in rules

![Out and in](./Images/Other-Sources-out1.jpg)

- Out and in rules

![Out and in](./Images/Other-Sources-out2.jpg)

- Reccurance Weekdays

![Reccurance Weekdays](./Images/ReccuranceWeekdays.jpg)

- Similarly for Weekend

![Reccurance Weekends](./Images/ReccuranceWeekends.jpg)

- Now Fixed profle 

![Fixed profile](./Images/FixedProbile.jpg)



- The following is the diagram downloaded from the Azure Portal, Vnet


### Additional Note for reference
1. Meta-Argument count - Terraform Function element()
2. Meta-Argument for_each with maps - Terraform Function lookup()

