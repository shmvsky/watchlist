<template>
	<div class="h-75">
		<div class="input-group">
			<span class="input-group-text" id="basic-addon1">#</span>
			<input type="text" 
				class="form-control name-input"
				placeholder="Название тега"
				v-model="name">
			<button class="btn btn-success btn-sm" v-if="isEditing" @click="updatePost"><fa icon="check"/></button>
			<button class="btn btn-danger btn-sm" v-if="isEditing" @click="cancelEdit"><fa icon="x"/></button>
			<button class="btn btn-success btn-sm" v-else @click="createPost"><fa icon="check"/></button>
		</div>

		<div class="overflow-auto h-75 mt-2">
			<ul class="list-group list-group-flush">
				<li v-for="tag in tags" :key="tag.id" class="text-bg-light list-group-item d-flex justify-content-between align-items-center">
					#{{ tag.name }}
					<div class="d-flex flex-row gap-2">
						<span class="badge text-bg-primary rounded-pill" @click="editTag(tag.id)"><fa icon="edit"/></span>
						<span class="badge text-bg-danger rounded-pill" @click="deleteTag(tag.id)"><fa icon="trash"/></span>
					</div>
				</li>
			</ul>
		</div>
	</div>
</template>
	
<script setup>
    import { ref, onMounted } from 'vue';

    const tags = ref([])
    const name = ref('')
    const tag_id = ref(0)
    const isEditing = ref(false)
    const API_URL = "http://localhost:3000/tags";


    onMounted(async() => {
        const res = await fetch(API_URL)
        tags.value = await res.json()
    })


    const createPost = async() => {
        const res = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name.value
            })
        })

        const data = await res.json()

        tags.value.push(data)
        name.value = ''
        tag_id.value = 0;
    }

    const updatePost = async() => {
        const res = await fetch (`${API_URL}/${tag_id.value}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name.value,
                id: tag_id.value
            })
        })

        const data = await res.json()

        const index = tags.value.findIndex(tag => tag.id === data.id)
        tags.value[index] = data

        name.value = ''
        tag_id.value = 0;
        isEditing.value = false
    }

    const cancelEdit = () => {
        name.value = ''
        tag_id.value = 0;
        isEditing.value = false
    }

    const deleteTag = async(id) => {
        await fetch (`${API_URL}/${id}`, {
            method: 'DELETE'
        })
        tags.value = tags.value.filter(tag => tag.id !== id)
    }

    const editTag = async(id) => {
        const tag = tags.value.find(tag => tag.id === id)

        name.value = tag.name
        tag_id.value = tag.id
        isEditing.value = true

        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        })
    }
</script>